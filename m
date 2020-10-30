Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61752A03D6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgJ3LOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbgJ3LOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:14:18 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3485C0613D2;
        Fri, 30 Oct 2020 04:14:17 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f38so4930876pgm.2;
        Fri, 30 Oct 2020 04:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUTBDFmOSWVlaKR+HYll/Mm2JTPEYK62zLmX9e2jIkw=;
        b=be3SGxKphXCXjE/yixOIsSlam3IWe8pBDVli09iAQX0Xx7vvbuZvYA1MwUVSuuGAG2
         ReqpGcjZLmvo7LCWtD7A3iLpxBgQXikQPcZ/VKJyDDXVmsXgl4pwSOfSwos0iIWIrn8l
         qH+i7FddMselQ+WhQ2KBJa+RQYBClT6ECNL0d69DnC2I59yPTwjVXclb04aJvvsuV89m
         dueqRk5wHQkBFAl5ElFh81Shmel/0EP56iU0GVSKModJv8XTXx8JpbW62ugPSDDoodNx
         xqT+bRxqcnZbJHvMVokTgetjEAfRbemAGolOg4uUrigw4Zgz3OL1Otto7KbhNPH9udAm
         K35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUTBDFmOSWVlaKR+HYll/Mm2JTPEYK62zLmX9e2jIkw=;
        b=N7vfglf68Qhsjqug52xBlUG39agjp6wWxTwdH9N54Lulb3oz6QmPyBLfTpmhXkUU4r
         gePrtdUHA8mzxfRHjDXedqfQAXRcrV7UyeRENyfN1CJVqJ/HxS15eutVJWNeSwMH75et
         EfjDpiOzwz+7ppRz1/hHn9SELjEjFXj/v+e83/zRFTf6K3pmnY34aBGjzSU/hWg7zGix
         kS5YmtGqTrhIQzJN/qMSOzk2ZetV45PrmDjVtz5GY8vpgDrNMpXe2P7SdtkcDWPPvS62
         cN8tCwkBKjqNP7/HksFRKNKfmLdLkbVmiwNps4SxcKwhQbqLevQB7YY6jH3L5aadk1GE
         2Jjg==
X-Gm-Message-State: AOAM53011BLwFsHz0zR/rsL1ucAjVfqJr+ibY8ZNwn84XCWcbBMFtVBG
        qDbzYQ3DyaiKEPxXPCKzTP99S7lcX76hzsY0TNwfeKNwXk6vyw==
X-Google-Smtp-Source: ABdhPJy8KjCA7+CjQ54Jai/lTxuiUgUJ6dwY86/fP/J+0VkwjdgeEdUD3jSZ4KCR/2gxFPG3Mx9bZgKgae3lkjdmLco=
X-Received: by 2002:a63:1e02:: with SMTP id e2mr1710264pge.74.1604056457509;
 Fri, 30 Oct 2020 04:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <1604026114-9038-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1604026114-9038-1-git-send-email-zou_wei@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Oct 2020 13:15:05 +0200
Message-ID: <CAHp75Veq+j4zCH-CktYU3Qua6ZKHpqzpzm_yWZuzzvH3amoChg@mail.gmail.com>
Subject: Re: [PATCH -next v2] platform/x86/dell-wmi-sysman: Make some symbols static
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 4:38 AM Zou Wei <zou_wei@huawei.com> wrote:
>
> Fix the following sparse warnings:
>
> drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c:38:23: warning: symbol 'po_is_pass_set' was not declared. Should it be static?
> drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c:70:23: warning: symbol 'po_current_password' was not declared. Should it be static?
> drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c:99:23: warning: symbol 'po_new_password' was not declared. Should it be static?
> drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c:103:23: warning: symbol 'po_min_pass_length' was not declared. Should it be static?
> drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c:107:23: warning: symbol 'po_max_pass_length' was not declared. Should it be static?
> drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c:116:23: warning: symbol 'po_mechanism' was not declared. Should it be static?
> drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c:129:23: warning: symbol 'po_role' was not declared. Should it be static?

Above can be shrinked by removing the path.

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
> v2:
> - put all of them in a way that each occupies only a single line

I meant the code, like

> -struct kobj_attribute po_is_pass_set =
> +static struct kobj_attribute po_is_pass_set =
>                 __ATTR_RO(is_enabled);

==>

static struct kobj_attribute po_is_pass_set = __ATTR_RO(is_enabled);

-- 
With Best Regards,
Andy Shevchenko
