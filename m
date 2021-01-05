Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B052EAC62
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbhAENyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:54:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:40644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbhAENyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:54:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1535522AB0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 13:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609854812;
        bh=MiE8ITogEUXlFjzWvi4WM1kbtTlPtXwDjowiAnjAELQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l366wlzMeJVkZHz0b3G7G6bLPznw+0wkObt8mNGFTIuMwX0X1p+FLWRuKmLvWwDpz
         2muTvWP0M/UMpZ44m86vrXmN3cx2GifQ/FNSeiW3HZ1bar6oZe8gmZT3khgr6t21+F
         JXTW1oI50rgPmjfYTWvcVTbwq87gqdrqfILsKUU/DNrRLiSNIVlhHzGBh34sl31gGR
         ErOtLqvSvSmMm6liaiQuwhHE1zBoxZhrOcyIPZ6KjxZ5A3/nVHINqbuVkiFJkXjjdb
         BdjWfpWN5a1VtZgObSQorVL7SB4wKNBXapmwTa88Tqi2BAEc9sCRVp7BSOL2iVpMel
         PtXdF+tvjOYIQ==
Received: by mail-oi1-f177.google.com with SMTP id 15so36050587oix.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 05:53:32 -0800 (PST)
X-Gm-Message-State: AOAM531w5Ih9QuPPd2RZgJ4REUIrpKNwH1w5ZgZ6Z7TGCLJJptzujLpQ
        zPWOsheB1aLkZfUIt03qj4ZJZ8royF6Y/TXVq7w=
X-Google-Smtp-Source: ABdhPJyAgueu0hcoFdpY5tTfx0w4LnDoL1WInyMluG0ioeEwekcxqHCWTgrVFa5RxpQifgirgE8Wx909LbG9WmduiG8=
X-Received: by 2002:aca:44d:: with SMTP id 74mr2735405oie.4.1609854811419;
 Tue, 05 Jan 2021 05:53:31 -0800 (PST)
MIME-Version: 1.0
References: <20210104105452.GM2809@kadam>
In-Reply-To: <20210104105452.GM2809@kadam>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 5 Jan 2021 14:53:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1EAWoqNxaJOSPsLdCF82QNAA-YWpYwA13cex_UC1iLyQ@mail.gmail.com>
Message-ID: <CAK8P3a1EAWoqNxaJOSPsLdCF82QNAA-YWpYwA13cex_UC1iLyQ@mail.gmail.com>
Subject: Re: drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:1056
 vchiq_get_user_ptr() error: uninitialized symbol 'ptr'.
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, Arnd Bergmann <arnd@arndb.de>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 11:54 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:

>
> 5d240a54be7e592 Arnd Bergmann 2020-09-18  1044  static inline int vchiq_get_user_ptr(void __user **buf, void __user *ubuf, int index)
> 5d240a54be7e592 Arnd Bergmann 2020-09-18  1045  {
> 5d240a54be7e592 Arnd Bergmann 2020-09-18  1046          int ret;
> 5d240a54be7e592 Arnd Bergmann 2020-09-18  1047
> 5d240a54be7e592 Arnd Bergmann 2020-09-18  1048          if (in_compat_syscall()) {
> 4184da4f316a549 Arnd Bergmann 2020-09-25  1049                  compat_uptr_t ptr32;
> 5d240a54be7e592 Arnd Bergmann 2020-09-18  1050                  compat_uptr_t __user *uptr = ubuf;
> 4184da4f316a549 Arnd Bergmann 2020-09-25  1051                  ret = get_user(ptr32, uptr + index);
> 5d240a54be7e592 Arnd Bergmann 2020-09-18  1052                  *buf = compat_ptr(ptr32);
> 5d240a54be7e592 Arnd Bergmann 2020-09-18  1053          } else {
> 4184da4f316a549 Arnd Bergmann 2020-09-25  1054                  uintptr_t ptr, __user *uptr = ubuf;
> 4184da4f316a549 Arnd Bergmann 2020-09-25  1055                  ret = get_user(ptr, uptr + index);
> 4184da4f316a549 Arnd Bergmann 2020-09-25 @1056                  *buf = (void __user *)ptr;
>
> If get_user() fails then this is uninitialized.  This will trigger a
> runtime error if the UBSan uninitialized behavior tool is enabled.

Thanks for the report, I sent a fix now.

      Arnd
