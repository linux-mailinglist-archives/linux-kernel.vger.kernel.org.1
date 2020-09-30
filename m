Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D448C27E0E2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 08:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgI3GL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 02:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3GL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 02:11:59 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226FFC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 23:11:57 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z17so675875lfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 23:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DsKOl62AFMxNuIVlAFoP9Xx1m2C2MzJvin92JKmzYRk=;
        b=jYbhyA14ANmP/eq1uqO6En5w2FI3Bq1GOW0LsirtifO7dv3ThKv8XCo5K7xX7/ROJG
         xeWXn7Y40ti1UKwmJyN26t3wpFTlIG0sHIS6bMMfMA5VHNJD0bbora6FS6UshHWgdfVh
         4f0rZKuEsATs/R6lLiS1oF2dli65R2phFKvlp+JLvw3f0JvOQetvsrZDqdEvF7Z59ebW
         iV38mDy5mGL+Xkj16xvtNyv3n9AOg02wH4AnGW3ugQ+XEs5GsbiiBFUnbmGZFYUx+VAV
         gPYHh6AWvI/sYfyWr0xy6L+CWroVYux/BaSv8+0J5GLM2OnZILghOPERY3BNl2EELNcx
         VcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DsKOl62AFMxNuIVlAFoP9Xx1m2C2MzJvin92JKmzYRk=;
        b=onh4fwsRXiGpfQeNiww3Aqu0T2SXBmSexdGZFnJL92ox8hVk9iHRMBBAxuYFqkyGdV
         31t5uNWhGN/MPuY3ipAfjxfD5+vumtUh3namZwm9EOB3MQV0s0aWoqWUCdSBcGuWj5Ya
         Ra903JY9NZ4tCxxCrZgOzqBFuTUEilifzvpdp0P+4BjU7ZhSRbjPkA+1tOFlz8C2/CjT
         6vC4O9U7p6q4tSzOpTikywnKVeijtm4LR519zZDmMMgAade0RyY9I58IeTdxsh4EpXY8
         2eCyEqa3qP7vfYLUJQBCYcJwLJrADYWjH92g3vh6DXstnHhEDuGocaWhr8L9kZAgF+GD
         r0JA==
X-Gm-Message-State: AOAM5336usu2naH1+1qvLS7+dWRrgP9nIbkGy0q8nZCvkhQqyYkv4yJF
        U1VpCiLB0d3ZMt+C7uHouTfZ8w==
X-Google-Smtp-Source: ABdhPJzpUUKp6CAYYQI7QSsx6RzOcEBHLn5WVGkFhK3ELKSXw4tbTO9ImS+4pwQHyMxM+74uU/N2+Q==
X-Received: by 2002:a05:6512:308f:: with SMTP id z15mr310479lfd.453.1601446315444;
        Tue, 29 Sep 2020 23:11:55 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id 9sm68457lfp.201.2020.09.29.23.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 23:11:54 -0700 (PDT)
Date:   Wed, 30 Sep 2020 08:11:53 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Elvira Khabirova <e.khabirova@omprussia.ru>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        vesa.jaaskelainen@vaisala.com, s.shtylyov@omprussia.ru,
        k.karasev@omprussia.ru
Subject: Re: [RFC PATCH] tee: add support for application-based session login
 methods
Message-ID: <20200930061153.GA738306@jade>
References: <20200917183803.4a0c5263@akathisia>
 <20200928134347.GA76106@jade>
 <20200930050101.034762a7@akathisia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930050101.034762a7@akathisia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 05:01:01AM +0300, Elvira Khabirova wrote:
> On Mon, 28 Sep 2020 15:43:47 +0200
> Jens Wiklander <jens.wiklander@linaro.org> wrote:
> 
> > Hi Elvira,
> > 
> > On Thu, Sep 17, 2020 at 06:38:03PM +0300, Elvira Khabirova wrote:
> > > GP TEE Client API in addition to login methods already supported
> > > in the kernel also defines several application-based methods:
> > > TEEC_LOGIN_APPLICATION, TEEC_LOGIN_USER_APPLICATION, and
> > > TEEC_LOGIN_GROUP_APPLICATION.
> > > 
> > > It specifies credentials generated for TEEC_LOGIN_APPLICATION as only
> > > depending on the identity of the program, being persistent within one
> > > implementation, across multiple invocations of the application
> > > and across power cycles, enabling them to be used to disambiguate
> > > persistent storage. The exact nature is REE-specific.
> > > 
> > > As the exact method of generating application identifier strings may
> > > vary between vendors, setups and installations, add two suggested
> > > methods and an exact framework for vendors to extend upon.
> > > 
> > > Signed-off-by: Elvira Khabirova <e.khabirova@omprussia.ru>
> > > ---
> > >  drivers/tee/Kconfig    |  29 +++++++++
> > >  drivers/tee/tee_core.c | 136 ++++++++++++++++++++++++++++++++++++++++-
> > >  2 files changed, 164 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/tee/Kconfig b/drivers/tee/Kconfig
> > > index e99d840c2511..4cd6e0d2aad5 100644
> > > --- a/drivers/tee/Kconfig
> > > +++ b/drivers/tee/Kconfig
> > > @@ -11,6 +11,35 @@ config TEE
> > >  	  This implements a generic interface towards a Trusted Execution
> > >  	  Environment (TEE).
> > >  
> > > +choice
> > > +	prompt "Application ID for client UUID"
> > > +	depends on TEE
> > > +	default TEE_APPID_PATH
> > > +	help
> > > +	  This option allows to choose which method will be used to generate
> > > +	  application identifiers for client UUID generation when login methods
> > > +	  TEE_LOGIN_APPLICATION, TEE_LOGIN_USER_APPLICATION
> > > +	  and TEE_LOGIN_GROUP_APPLICATION are used.
> > > +	  Please be mindful of the security of each method in your particular
> > > +	  installation.
> > > +
> > > +	config TEE_APPID_PATH
> > > +		bool "Path-based application ID"
> > > +		help
> > > +		  Use the executable's path as an application ID.
> > > +
> > > +	config TEE_APPID_SECURITY
> > > +		bool "Security extended attribute based application ID"
> > > +		help
> > > +		  Use the executable's security extended attribute as an application ID.
> > > +endchoice
> > > +
> > > +config TEE_APPID_SECURITY_XATTR
> > > +	string "Security extended attribute to use for application ID"
> > > +	depends on TEE_APPID_SECURITY
> > > +	help
> > > +	  Attribute to be used as an application ID (with the security prefix removed).
> > > +
> > >  if TEE
> > >  
> > >  menu "TEE drivers"
> > > diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> > > index 64637e09a095..19c965dd212b 100644
> > > --- a/drivers/tee/tee_core.c
> > > +++ b/drivers/tee/tee_core.c
> > > @@ -7,8 +7,10 @@
> > >  
> > >  #include <linux/cdev.h>
> > >  #include <linux/cred.h>
> > > +#include <linux/file.h>
> > >  #include <linux/fs.h>
> > >  #include <linux/idr.h>
> > > +#include <linux/mm.h>
> > >  #include <linux/module.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/tee_drv.h>
> > > @@ -17,11 +19,15 @@
> > >  #include <crypto/sha.h>
> > >  #include "tee_private.h"
> > >  
> > > +#ifdef CONFIG_TEE_APPID_SECURITY
> > No need for the ifdef, just inlude the file unconditionally above.
> > 
> > > +#include <linux/security.h>
> > > +#endif
> > > +
> > >  #define TEE_NUM_DEVICES	32
> > >  
> > >  #define TEE_IOCTL_PARAM_SIZE(x) (sizeof(struct tee_param) * (x))
> > >  
> > > -#define TEE_UUID_NS_NAME_SIZE	128
> > > +#define TEE_UUID_NS_NAME_SIZE	PATH_MAX
> > >  
> > >  /*
> > >   * TEE Client UUID name space identifier (UUIDv4)
> > > @@ -125,6 +131,67 @@ static int tee_release(struct inode *inode, struct file *filp)
> > >  	return 0;
> > >  }
> > >  
> > > +#ifdef CONFIG_TEE_APPID_SECURITY
> > > +static const char *tee_session_get_application_id(void **data)
> > static char *get_app_id(void) should be enough.
> > 
> > > +{
> > > +	struct file *exe_file;
> > > +	const char *name = CONFIG_TEE_APPID_SECURITY_XATTR;
> > > +	int len;
> > > +
> > > +	exe_file = get_mm_exe_file(current->mm);
> > > +	if (!exe_file)
> > > +		return ERR_PTR(-ENOENT);
> > > +
> > > +	if (!exe_file->f_inode) {
> > > +		fput(exe_file);
> > > +		return ERR_PTR(-ENOENT);
> > > +	}
> > > +
> > 
> > You could perhaps add a comment here on the expected properties of this
> > data. Something along (don't know if I'm even close) "string
> > representation of the the hash of the binary and time stamp".
> > 
> > > +	len = security_inode_getsecurity(exe_file->f_inode, name, data, true);
> > > +	if (len < 0)
> > > +		return ERR_PTR(len);
> > > +
> > > +	fput(exe_file);
> > > +
> > > +	return *data;
> > > +}
> > > +#endif /* CONFIG_TEE_APPID_SECURITY */
> > > +
> > > +#ifdef CONFIG_TEE_APPID_PATH
> > > +static const char *tee_session_get_application_id(void **data)
> > > +{
> > > +	struct file *exe_file;
> > > +	char *path;
> > > +
> > > +	*data = kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
> > > +	if (!*data)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	exe_file = get_mm_exe_file(current->mm);
> > > +	if (!exe_file) {
> > > +		kfree(*data);
> > > +		return ERR_PTR(-ENOENT);
> > > +	}
> > > +
> > > +	path = file_path(exe_file, *data, TEE_UUID_NS_NAME_SIZE);
> > > +	if (IS_ERR(path)) {
> > > +		kfree(*data);
> > > +		return path;
> > > +	}
> > > +
> > > +	fput(exe_file);
> > > +
> > > +	return path;
> > > +}
> > > +#endif /* CONFIG_TEE_APPID_PATH */
> > > +
> > > +#if defined(CONFIG_TEE_APPID_PATH) || defined(CONFIG_TEE_APPID_SECURITY)
> > > +static void tee_session_free_application_id(void *data)
> > > +{
> > > +	kfree(data);
> > > +}
> > This function isn't needed, we can call kfree() directly.
> > 
> > > +#endif /* CONFIG_TEE_APPID_PATH || CONFIG_TEE_APPID_SECURITY */
> > > +
> > >  /**
> > >   * uuid_v5() - Calculate UUIDv5
> > >   * @uuid: Resulting UUID
> > > @@ -197,6 +264,8 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
> > >  	gid_t ns_grp = (gid_t)-1;
> > >  	kgid_t grp = INVALID_GID;
> > >  	char *name = NULL;
> > > +	void *application_id_data = NULL;
> > This isn't needed
> The only reason application_id_data exists (and get_application_id has a parameter)
> is because when defined(CONFIG_TEE_APPID_PATH), file_path() returns a pointer
> that often starts at an offset into the buffer (see the comment above d_path()).
> Therefore we end up with a buffer that's not equal to application_id which we
> want to free later. The other way (other than having a void **data parameter)
> would be to allocate a new buffer, copy the resulting path there, and return
> the new buffer instead of the one used by file_path().
> Let me know which solution is preferred.

Good point. Please use the pattern you're already using. I'd prefer a slightly
shorter name though. app_id_data perhaps?

Thanks,
Jens

> 
> > > +	const char *application_id = NULL;
> > char *app_id = NULL;
> > 
> > >  	int name_len;
> > >  	int rc;
> > >  
> > > @@ -217,6 +286,14 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
> > >  	 * For TEEC_LOGIN_GROUP:
> > >  	 * gid=<gid>
> > >  	 *
> > > +	 * For TEEC_LOGIN_APPLICATION:
> > > +	 * app=<application id>
> > > +	 *
> > > +	 * For TEEC_LOGIN_USER_APPLICATION:
> > > +	 * uid=<uid>:app=<application id>
> > > +	 *
> > > +	 * For TEEC_LOGIN_GROUP_APPLICATION:
> > > +	 * gid=<gid>:app=<application id>
> > >  	 */
> > >  
> > >  	name = kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
> > > @@ -249,6 +326,63 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 connection_method,
> > >  		}
> > >  		break;
> > >  
> > > +	case TEE_IOCTL_LOGIN_APPLICATION:
> > > +		application_id = tee_session_get_application_id(&application_id_data);
> > > +		if (IS_ERR(application_id)) {
> > > +			rc = PTR_ERR(application_id);
> > > +			goto out_free_name;
> > > +		}
> > > +
> > > +		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "app=%s",
> > > +				    application_id);
> > > +		tee_session_free_application_id(application_id_data);
> > > +
> > > +		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
> > > +			rc = -E2BIG;
> > > +			goto out_free_name;
> > > +		}
> > It looks like we remove these tests and replace them with
> > if (name_len < TEE_UUID_NS_NAME_SIZE)
> >         rc = uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
> > else
> >         rc = -E2BIG
> > 
> > below, just above the "out_free_name:" label.
> > 
> > This function is small and simple enough that it should be easy to see
> > what's going on any way.
> > 
> > Thanks,
> > Jens
> > 
> > > +		break;
> > > +
> > > +	case TEE_IOCTL_LOGIN_USER_APPLICATION:
> > > +		application_id = tee_session_get_application_id(&application_id_data);
> > > +		if (IS_ERR(application_id)) {
> > > +			rc = PTR_ERR(application_id);
> > > +			goto out_free_name;
> > > +		}
> > > +
> > > +		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=%x:app=%s",
> > > +				    current_euid().val, application_id);
> > > +		tee_session_free_application_id(application_id_data);
> > > +
> > > +		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
> > > +			rc = -E2BIG;
> > > +			goto out_free_name;
> > > +		}
> > > +		break;
> > > +
> > > +	case TEE_IOCTL_LOGIN_GROUP_APPLICATION:
> > > +		memcpy(&ns_grp, connection_data, sizeof(gid_t));
> > > +		grp = make_kgid(current_user_ns(), ns_grp);
> > > +		if (!gid_valid(grp) || !in_egroup_p(grp)) {
> > > +			rc = -EPERM;
> > > +			goto out_free_name;
> > > +		}
> > > +
> > > +		application_id = tee_session_get_application_id(&application_id_data);
> > > +		if (IS_ERR(application_id)) {
> > > +			rc = PTR_ERR(application_id);
> > > +			goto out_free_name;
> > > +		}
> > > +		name_len = snprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=%x:app=%s",
> > > +				    grp.val, application_id);
> > > +		tee_session_free_application_id(application_id_data);
> > > +
> > > +		if (name_len >= TEE_UUID_NS_NAME_SIZE) {
> > > +			rc = -E2BIG;
> > > +			goto out_free_name;
> > > +		}
> > > +		break;
> > > +
> > >  	default:
> > >  		rc = -EINVAL;
> > >  		goto out_free_name;
> > > -- 
> > > 2.28.0
> > > 
> 
