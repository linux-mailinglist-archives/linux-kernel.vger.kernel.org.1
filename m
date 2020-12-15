Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44E42DA64F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 03:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgLOCf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 21:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbgLOCfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 21:35:12 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BA3C061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 18:34:32 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id r5so19346901eda.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 18:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SDS1IoTT9e9jG5qNkQs06xUgvZJCIKhgAel2bPuApCE=;
        b=YVwepcNaKWGBwLyybWAs/z4598H4hyPpUJJz2SiNQXol5N1OYOpE7/Pt+SvK/DdeBa
         /S3pfhRqEySC+QQPncFSEzKbDGVtC8qJPw5kRntKdmOI/4y32a7vE+CfKIqk6vWaJNq9
         krUDUbllzMiLAf97Fhs9TsLAgwCzbq4a24WY1VPLJtz7eFC5BGkBX9RYjITlIpHBy3kn
         y50RbWt0ES+Lo47mewF0R5hk+JZnq6DiPqZ6POCMI9zPkSGul/djbLWaKijdILR0u4A3
         iETMSY4KdSupIz7MUuI+6WbynJhi6Wi3gR0CIgDISvQOKzqD3VMy91QWH8jeY4a6jqCE
         0v4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDS1IoTT9e9jG5qNkQs06xUgvZJCIKhgAel2bPuApCE=;
        b=Qmc6PZwqfvoSK7s1v7+mADHVzklBhaiUuGH3XxKIgK0yN+bTfqYUl1bP+MM47R9VLq
         Qvf075z8jJEvxymNcJ+X/GluXSJUL/xfe0i8OHrGY3UkGih3jnDbFjsurSNR3h3gcU/1
         5vjHwtf/AMHQuYEj/KnJJoY5r0arhIGafpvaY6K/dPvZUGQOl7HfMd5j3BICmtSnxF4p
         dTbSHfEAmQu9k/bzUejsrl6GzYHYYzb+0GnuopOCx+uVzdHXrAZu6pjTl3Yta6INFW6Z
         Tuk5vsQLzACYlRs7mUQ76qiljeuUpPhAkDoyvJ/LzjT9IROsG00LJl7zRFG37/1wdhYz
         emRw==
X-Gm-Message-State: AOAM530IElE4MdFs4W2qFkiYxb3wCkiwaCla5SAcpCctwbIfDqn67MN2
        4RoTUZ3wjikNaRHCMp9Dyp4Xjc21Uo26eKXMXgkU
X-Google-Smtp-Source: ABdhPJxB5mO16JID/xZpY5y+REkiQAGxjKT/tvKMyXIFEReGjo7zDWN9vB7Psgey9fhfS5qYIxFBVAwBderGUJp/KuI=
X-Received: by 2002:a05:6402:44b:: with SMTP id p11mr27550671edw.164.1607999670809;
 Mon, 14 Dec 2020 18:34:30 -0800 (PST)
MIME-Version: 1.0
References: <20201211084254.2038-1-zhengyongjun3@huawei.com> <20201211153321.GF2015948@madcap2.tricolour.ca>
In-Reply-To: <20201211153321.GF2015948@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 14 Dec 2020 21:34:19 -0500
Message-ID: <CAHC9VhS9zCzWLhwE=6AOr7sO-LUdLDS6sb4tC2tDuT=LRYdzHw@mail.gmail.com>
Subject: Re: [PATCH -next] kernel/audit: convert comma to semicolon
To:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        Richard Guy Briggs <rgb@redhat.com>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 10:33 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-12-11 16:42, Zheng Yongjun wrote:
> > Replace a comma between expression statements by a semicolon.
> >
> > Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> > ---
> >  kernel/audit.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 68cee3bc8cfe..c8497115be35 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -2282,7 +2282,7 @@ static void audit_log_set_loginuid(kuid_t koldloginuid, kuid_t kloginuid,
> >
> >       uid = from_kuid(&init_user_ns, task_uid(current));
> >       oldloginuid = from_kuid(&init_user_ns, koldloginuid);
> > -     loginuid = from_kuid(&init_user_ns, kloginuid),
> > +     loginuid = from_kuid(&init_user_ns, kloginuid);
>
> Nice catch.  That went unnoticed through 3 patches, the last two mine...

Yes, thanks for catching this and submitting a patch.  However, as it
came very late in the v5.10-rcX release cycle I'm going to wait until
after this merge window to merge it into audit/next.

> Not quite sure why no compiler complained about it...

Because it is legal; odd, but legal. :)

The comma operator allows multiple expressions to be executed with
only the last expression returned.  Take the example below:

% cat test.c
#include <stdlib.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
       int a, b, c;

       a = (b = 1, c = 2);
       printf("a = %d, b = %d, c = %d\n", a, b, c);

       return 0;
}
% gcc -o test test.c
% ./test
a = 2, b = 1, c = 2

... we see both "b=1" and "c=2" are executed, and the last statement
in the comma separated list of expressions is used as the right-hand
value in the "a" assignment.

In the case of this patch, the existing code is actually okay: both
expressions are executed and we don't assign either expression's value
to a variable so it doesn't matter.  However, it definitely looks odd
and is something we should fix.

-- 
paul moore
www.paul-moore.com
