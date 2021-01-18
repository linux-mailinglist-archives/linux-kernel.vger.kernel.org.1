Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEC32FA086
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391896AbhARM4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391968AbhARMzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:55:11 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2158C061573;
        Mon, 18 Jan 2021 04:54:28 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o19so23935437lfo.1;
        Mon, 18 Jan 2021 04:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xxnQ4a5Y/QKm8xPbIkC67QSRdkRRiFdNuFxeCy+15C0=;
        b=Ov5oDW+4ELdn7I7iaZyGLTK+qXwCnz4Chck5bLJym9aE9c3s+7OwY5TeM9YdwkY6O2
         oA+lb/fQB4jKQkp7qRVgbmfa+6At1Dgf6HJ5VzusomN2fjFt6YmZ9WPU2uGn9ip8iKq+
         U3ipRSUHBP4TYEVyqWOy7dUywZQOqTnefK3+aB6ZH0Nf36O9t754VjTeLvuET5tkHj0N
         Pzgvqupm7qKxc5zpP4irnIp4lQGjZ6kzAqjpFKzVZGY4qXCKS52I9XoxitjtZXiaLIPA
         20dHkDo1tkym1VyXain9LcXJcxpCIlMYDy5BTI5CuP5N5H4RTxsnauImKaH5y0MV+inE
         ZoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxnQ4a5Y/QKm8xPbIkC67QSRdkRRiFdNuFxeCy+15C0=;
        b=obn+sCm9YhGZsla8j87DwcbApO+NvpytCt5W+4aF/2DcjNK9/67e/guqr49JBPVebl
         M/mcSuYMVCVZ6Q6Y3y4ra7kWj8UUBz9FGZonC8+p5xUAUJi4PgouiEH79tkvWb9vvTvq
         qemZdn3uOktYVUxCfrTr2+30Qf9Ia2oqz2xkUCqUmRZKG2o8xATXaUf11ZU3yphv2g0f
         f/PzjzP7I/iCCsyg9lbCqbvMO24bEFaLD3yhuzY/ycKD6HMlYFABmVquPykxMtN1FOZ+
         CrVyg4Ehyxp49TOt/B+KDOl5ATTFkjHAnwia9mFVN+h7iKlmaN7jF3OCBHZssiKvzHmI
         yfgQ==
X-Gm-Message-State: AOAM531gUJvSug7cM//jVdSO6vcCPvZWKzx4QloIXeeeuqXM9v/lZe3E
        CXaAZjodzagCdpTiQSp4LuhC+kVDpOd2hIpfdYw=
X-Google-Smtp-Source: ABdhPJzqW6WB16HvP5joeYqlBn0VGC/PYl4piUnNDIiGW9voYfNCowuuARSChubhPTgNjadGVrEwrlV6QMUbcR4QZYc=
X-Received: by 2002:ac2:5497:: with SMTP id t23mr11377211lfk.534.1610974467169;
 Mon, 18 Jan 2021 04:54:27 -0800 (PST)
MIME-Version: 1.0
References: <20210115213142.35003-1-alcooperx@gmail.com> <878s8qwkgz.fsf@kernel.org>
 <YAVy3KKu7n522aUU@kroah.com> <87wnwav3hi.fsf@kernel.org>
In-Reply-To: <87wnwav3hi.fsf@kernel.org>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Mon, 18 Jan 2021 13:54:16 +0100
Message-ID: <CAMeQTsbQcbrBMvh2uzPjCJ1bMDQtZTEUMJ9Y9mhmGTnxhN-3+A@mail.gmail.com>
Subject: Re: [PATCH] usb: bdc: Remove the BDC PCI driver
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        USB list <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 1:22 PM Felipe Balbi <balbi@kernel.org> wrote:
>
>
> Hi,
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> >> Al Cooper <alcooperx@gmail.com> writes:
> >> > The BDC PCI driver was only used for design verification with
> >> > an PCI/FPGA board. The board no longer exists and is not in use
> >> > anywhere. All instances of this core now exist as a memory mapped
> >> > device on the platform bus.
> >> >
> >> > NOTE: This only removes the PCI driver and does not remove the
> >> > platform driver.
> >> >
> >> > Signed-off-by: Al Cooper <alcooperx@gmail.com>
> >>
> >> It sounds like it could be used for pre-silicon verification of newer
> >> Core Releases, much like Synopsys still uses the HAPS (with mainline
> >> linux, mind you) for silicon validation.
> >>
> >> Why would we delete this small shim if it *could* still be useful?
> >
> > It ends up conflicting with the PCI id of a device that is actually in
> > the wild (a camera on Apple laptops).  So it's good to drop this driver
> > so the wrong driver doesn't get constantly bound to the wrong device.
>
> I see. Oh well...

It would also help if this got disabled in stable so existing kernels
stop loading bdc.

Can this patch go directly into stable or should I send a patch that
adds "depends on BROKEN"?

-Patrik
