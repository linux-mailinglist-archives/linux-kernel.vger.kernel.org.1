Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B760D297E14
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 21:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763825AbgJXTV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 15:21:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763681AbgJXTV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 15:21:28 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E817720709
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 19:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603567288;
        bh=JVOtaKdH1EtSuGmR6kfsv5i3Q8TYXIkcMRHcLeY/C9Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=plKXKA4qYOw3F7cYinTY5CFGZTiQwWdDcLvgpdGKudMRtUcqhuRuQq2MMZ6A8mKdF
         /Yiuo3Y/9X+DW4AR3/FIsq+e+D6LWMdA1h6GY63GqrZtvESFNsxEiGiV4Bo8FaeG55
         fYLZBFtS88hWI/Ee8ihNtCo/Ukh728oSIlqCrAoo=
Received: by mail-qt1-f182.google.com with SMTP id e6so3950179qtw.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 12:21:27 -0700 (PDT)
X-Gm-Message-State: AOAM53214ho38z/thPseQwzQsSlJ16Sqn+hzovoyoY/vNcxbcxHHUpD3
        AqPjuYG+5L9Qd3ROqUgwSYxz7AWZSk0lIyektG4=
X-Google-Smtp-Source: ABdhPJyhyn2fnoh3jaY/Yy4Mn1Vh46i0l5GbzMkoQSTPMlbc9rc08yulVqjBQDaaAIOTXLpsoVUQXi+x2GqW93oz3Sw=
X-Received: by 2002:ac8:64a:: with SMTP id e10mr8303474qth.142.1603567287128;
 Sat, 24 Oct 2020 12:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201008182713.2764-1-harshalchau04@gmail.com>
 <20201009045734.GA112189@kroah.com> <CADVatmONWsfsj4-WKhNAcXjKXbUrgyD6UpK+ML6TNpqtp8be9A@mail.gmail.com>
 <CADVatmOf18xUEvjWFzenut=KsHtoEZ5OSZF1oCqFJsbkx_Mb9g@mail.gmail.com>
 <CAFEvwukbxCY4wffd_1jLo+vjfXfBC4sFDpJ1vY4wfT+=yFA--w@mail.gmail.com>
 <0eb6f48d05624c8abaf00ae1bd4d88a9@AcuMS.aculab.com> <CAFEvwu=76mPtXSEgpwSoRC0rC0tkU5BiEx1X5O2VwVSPJ7m4Rw@mail.gmail.com>
In-Reply-To: <CAFEvwu=76mPtXSEgpwSoRC0rC0tkU5BiEx1X5O2VwVSPJ7m4Rw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sat, 24 Oct 2020 21:21:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0y5MjP7AXOpmqc7xpGFCSvTGWHPT_eev5OpJJGVcRVdA@mail.gmail.com>
Message-ID: <CAK8P3a0y5MjP7AXOpmqc7xpGFCSvTGWHPT_eev5OpJJGVcRVdA@mail.gmail.com>
Subject: Re: [PATCH] char: ppdev: check if ioctl argument is present and valid
To:     harshal chaudhari <harshalchau04@gmail.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 24, 2020 at 5:54 PM harshal chaudhari
<harshalchau04@gmail.com> wrote:
> On Tue, Oct 13, 2020 at 4:42 PM David Laight <David.Laight@aculab.com> wrote:

> So I am a little bit confused about this check whether it's required or not
> Please could you point me in the right direction?
>
> In any case, thanks for your help ...
>
> Here is a driver source located in: linux/drivers/misc/xilinx_sdfec.c
>
> static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
> unsigned long data)
> {
> struct xsdfec_dev *xsdfec;
> void __user *arg = NULL;
> int rval = -EINVAL;
>
> if (_IOC_TYPE(cmd) != XSDFEC_MAGIC)
>                return -ENOTTY;
>
> /* check if ioctl argument is present and valid */
> if (_IOC_DIR(cmd) != _IOC_NONE)
> {
>         arg = (void __user *)data;
>         if (!arg)
>                    return rval;
> }
>

All of this can be removed, and replaced with unconditional

     void __user *arg = (void __user *)data;
     int rval;

with an "rval = -ENOTTY" added in the 'default' case. This will
make it behave more like other drivers, returning -ENOTTY for
any unknown ioctl command, and returning -EFAULT for all
invalid pointers, including NULL.

xsdfec_dev_compat_ioctl() can removed as well, with the file operations
changed to an unconditional (removing the #ifdef)

      .compat_ioctl = compat_ptr_ioctl(),

This will not affect behavior, it's just another simplification.


          Arnd
