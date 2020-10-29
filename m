Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C00D29EB07
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 12:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgJ2Lxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 07:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgJ2Lxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 07:53:32 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CD8C0613CF;
        Thu, 29 Oct 2020 04:53:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id e7so2108241pfn.12;
        Thu, 29 Oct 2020 04:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Jxchq7sCXMiWwVgsGg6TDfLEzPFFR+3USmaiSFuWJc=;
        b=R/UxXVqNgzuEvy9FEU7T22/1vP52mU1PCwePPqXXMSTpgN6sG3AOzIS8zMX35CqsD4
         qjMZFGGRpJgMGj9Ltcy9dk/iQMoTk5CLg0QATjsBUmYp+QgigGv92n/Wdzy2pb/+HIQH
         qaJSp1hCkwa9hhkENXgpvMDRoEddtf43EMSk5CAFFm+rLXFD2WL7ZssjE857lHW53d/f
         F3Q6bS3VJmMdAmqhsvp4y+X4koDE46B0w/yb8uFZ1ahK+2g0DJHc0Bqq9hrpTWGKWsuA
         odKT6M8jmFHxeAYoyb6DNPWKkvoGCcLng3w9i84KeYn5YYL9tJRtUfUqB+k1lUgt+fUY
         HG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Jxchq7sCXMiWwVgsGg6TDfLEzPFFR+3USmaiSFuWJc=;
        b=SbXjnrrERHTmYTJxOZRr2OgCaKmwfumGLMBQGxz+q1yKkAskPSGZFF8uSCYiz3jSjJ
         gmZXI3Zd6uSkakwC4KWbNDZbmuC4N8z20QzKfjMaN5YrvMinJvbxqMK5HB+gQx6cnbEy
         egtPs/o4CfbgO3tpT2TPQj0JV+iFmLWyL3kacayBuhkm1eG0OSIP9uIXx+fmHb16L6eI
         HY9ZiOwYzEyVzzTwRAdnysDFZE75SXSWIC8S62gBAfHGmAAzUWnf0xQdoN/BFN98W3x8
         BTAZLgfNY18Vh5ENR1jLLVIq2g+LZx1uDgL7K6ylvgP2upr3d5KNDUAczN7NYGNn1pOz
         Wyhg==
X-Gm-Message-State: AOAM530kw9ZH/nBzwSx6LS7KHCg3/EldCgGWWfKWoTQT9aUZx73+xy3p
        zZjk9ocqa3pf/DE6zLPOHXqakq2evKRVX+JJerI=
X-Google-Smtp-Source: ABdhPJzOuWEOsKhl3x4cJJOs0Mf2T3Q+nd6qlZRxnXUrgntCEabtk2oR9XYT8Iez7oBb/cXC0wfzVOMMTG+N9FuQHGo=
X-Received: by 2002:a17:90b:305:: with SMTP id ay5mr4124931pjb.129.1603972410379;
 Thu, 29 Oct 2020 04:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <1603971249-64044-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1603971249-64044-1-git-send-email-zou_wei@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Oct 2020 13:54:19 +0200
Message-ID: <CAHp75VcbXEQ7YVEOMsB2cy50HoBaH9eb6rgN=7ou-UMrH62TRQ@mail.gmail.com>
Subject: Re: [PATCH -next] platform/x86/dell-wmi-sysman: Make some symbols static
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 1:22 PM Zou Wei <zou_wei@huawei.com> wrote:
>
> Fix the following sparse warnings:
>
> drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c:38:23:
> warning: symbol 'po_is_pass_set' was not declared. Should it be static?
> drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c:70:23: warning:
> symbol 'po_current_password' was not declared. Should it be static?
> drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c:99:23:
> warning: symbol 'po_new_password' was not declared. Should it be static?
> drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c:103:23:
> warning: symbol 'po_min_pass_length' was not declared. Should it be static?
> drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c:107:23:
> warning: symbol 'po_max_pass_length' was not declared. Should it be static?
> drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c:116:23:
> warning: symbol 'po_mechanism' was not declared. Should it be static?
> drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c:129:23:
> warning: symbol 'po_role' was not declared. Should it be static?
>
> po_is_pass_set, po_current_password, po_new_password,
> po_min_pass_length, po_max_pass_length, po_mechanism and po_role
> have only call within passobj-attributes.c
> They should be static

I think at the same time you may put all of them in a way that each
occupies only a single line.

...

> -struct kobj_attribute po_role =
> +static struct kobj_attribute po_role =
>         __ATTR_RO(role);


-- 
With Best Regards,
Andy Shevchenko
