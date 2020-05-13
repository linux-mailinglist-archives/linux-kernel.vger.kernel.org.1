Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F341D19AD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 17:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgEMPmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 11:42:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729539AbgEMPmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:42:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 200DE20690;
        Wed, 13 May 2020 15:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589384551;
        bh=c2THWjPXmYT+eNkLtJ/K4xjf95VTRhhuKD9WCsZoTzs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X2q2P4hFX1QwA3UvtIli2RaL+P5gZ6EAywEiGaPU1DW6cXmwIgcS3c8YCJp5Vdoam
         2oU9Z9T1rlmiDNJFt3D0DXVGp7MdWEZH9JseV7nhUsQkxRc8xU9GnXu3fpq9uEVboQ
         eeRvZ/V21A9seJSgI9O/eaLhy7T2/PmJ5/dySkCw=
Date:   Wed, 13 May 2020 17:42:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] kobject: Make sure the parent does not get released
 before its children
Message-ID: <20200513154228.GC1360420@kroah.com>
References: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 06:18:40PM +0300, Heikki Krogerus wrote:
> In the function kobject_cleanup(), kobject_del(kobj) is
> called before the kobj->release(). That makes it possible to
> release the parent of the kobject before the kobject itself.
> 
> To fix that, adding function __kboject_del() that does
> everything that kobject_del() does except release the parent
> reference. kobject_cleanup() then calls __kobject_del()
> instead of kobject_del(), and separately decrements the
> reference count of the parent kobject after kobj->release()
> has been called.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  lib/kobject.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index 65fa7bf70c57..32432036bef8 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -599,14 +599,7 @@ int kobject_move(struct kobject *kobj, struct kobject *new_parent)
>  }
>  EXPORT_SYMBOL_GPL(kobject_move);
>  
> -/**
> - * kobject_del() - Unlink kobject from hierarchy.
> - * @kobj: object.
> - *
> - * This is the function that should be called to delete an object
> - * successfully added via kobject_add().
> - */
> -void kobject_del(struct kobject *kobj)
> +static void __kobject_del(struct kobject *kobj)
>  {
>  	struct kernfs_node *sd;
>  	const struct kobj_type *ktype;
> @@ -625,9 +618,23 @@ void kobject_del(struct kobject *kobj)
>  
>  	kobj->state_in_sysfs = 0;
>  	kobj_kset_leave(kobj);
> -	kobject_put(kobj->parent);
>  	kobj->parent = NULL;
>  }
> +
> +/**
> + * kobject_del() - Unlink kobject from hierarchy.
> + * @kobj: object.
> + *
> + * This is the function that should be called to delete an object
> + * successfully added via kobject_add().
> + */
> +void kobject_del(struct kobject *kobj)
> +{
> +	struct kobject *parent = kobj->parent;
> +
> +	__kobject_del(kobj);
> +	kobject_put(parent);
> +}
>  EXPORT_SYMBOL(kobject_del);
>  
>  /**
> @@ -663,6 +670,7 @@ EXPORT_SYMBOL(kobject_get_unless_zero);
>   */
>  static void kobject_cleanup(struct kobject *kobj)
>  {
> +	struct kobject *parent = kobj->parent;
>  	struct kobj_type *t = get_ktype(kobj);
>  	const char *name = kobj->name;
>  
> @@ -684,7 +692,7 @@ static void kobject_cleanup(struct kobject *kobj)
>  	if (kobj->state_in_sysfs) {
>  		pr_debug("kobject: '%s' (%p): auto cleanup kobject_del\n",
>  			 kobject_name(kobj), kobj);
> -		kobject_del(kobj);
> +		__kobject_del(kobj);
>  	}
>  
>  	if (t && t->release) {
> @@ -698,6 +706,8 @@ static void kobject_cleanup(struct kobject *kobj)
>  		pr_debug("kobject: '%s': free name\n", name);
>  		kfree_const(name);
>  	}
> +
> +	kobject_put(parent);
>  }
>  
>  #ifdef CONFIG_DEBUG_KOBJECT_RELEASE
> -- 
> 2.26.2
> 

Is this the older patch we talked about before, or something else?

I can't remember how we left that thread...

thanks,

greg k-h
