Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537871AABFA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 17:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414733AbgDOPep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 11:34:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43876 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1414720AbgDOPee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586964873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EOsn9WzC2Po9PCvhFuHMXouRRoh7kiQm7oVuP+zKwJQ=;
        b=hwn9oie776lvjt1MqBo0gV5zgnVgT5cKDp/Se48IZ7faeO53EuvJl6TSEi4KMF7a7hwGMF
        s0XV6T2W3dRJSVDCvdU0eVd1Vv6fR72U1/zeIIjH7Y4oOMuo9dELnhE3M6JyhO144YeuT2
        1dfFW/qWB3XaFUmajZvoBuB3SmemApI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-4X0w2peNPB6VLyvD1vLIJg-1; Wed, 15 Apr 2020 11:34:29 -0400
X-MC-Unique: 4X0w2peNPB6VLyvD1vLIJg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCC2C6A6;
        Wed, 15 Apr 2020 15:34:27 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E200560BF1;
        Wed, 15 Apr 2020 15:34:20 +0000 (UTC)
Date:   Wed, 15 Apr 2020 11:34:17 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Amol Grover <frextrite@gmail.com>, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] kernel: audit.c: Add __rcu notation to RCU pointer
Message-ID: <20200415153417.svpbimg66vbeuk7u@madcap2.tricolour.ca>
References: <20191128153203.GA23803@workstation-kernel-dev>
 <20191130020742.GF157739@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191130020742.GF157739@google.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-11-29 21:07, Joel Fernandes wrote:
> On Thu, Nov 28, 2019 at 09:02:03PM +0530, Amol Grover wrote:
> > add __rcu notation to RCU protected global pointer auditd_conn
> 
> Again, please use proper punctuation and captilization. This is unacceptable.
> Please put more effort into changelog.
> 
> Otherwise the patch diff itself looks good to me, with the above nit
> corrected, you could add my tag to the next revision:
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> thanks,
> 
>  - Joel
> 
> > 
> > Fixes multiple instances of sparse error:
> > error: incompatible types in comparison expression
> > (different address spaces)

Amol or Joel: Is there a reproducer recipe for this?

> > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > ---
> > v2:
> > - fix erroneous RCU pointer initialization
> > 
> >  kernel/audit.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index da8dc0db5bd3..ff7cfc61f53d 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -102,12 +102,13 @@ struct audit_net {
> >   * This struct is RCU protected; you must either hold the RCU lock for reading
> >   * or the associated spinlock for writing.
> >   */
> > -static struct auditd_connection {
> > +struct auditd_connection {
> >  	struct pid *pid;
> >  	u32 portid;
> >  	struct net *net;
> >  	struct rcu_head rcu;
> > -} *auditd_conn = NULL;
> > +};
> > +static struct auditd_connection __rcu *auditd_conn;
> >  static DEFINE_SPINLOCK(auditd_conn_lock);
> >  
> >  /* If audit_rate_limit is non-zero, limit the rate of sending audit records
> > -- 
> > 2.24.0

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

