Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A482F2998AA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 22:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbgJZVWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 17:22:45 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35764 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbgJZVWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 17:22:45 -0400
Received: by mail-ot1-f67.google.com with SMTP id n11so9347276ota.2;
        Mon, 26 Oct 2020 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VmNejhIxbwZr0QHNkLPt+u87p3b3DQWpfaWDeZvLjj8=;
        b=E9kJ7MmwEA7+su/st6egr5S8QWGNkH3yz9EL9BIVxYjSzQwCQB7VfBOeHQmWkwAMxL
         DTxLuraa1u0rN/T6bud8jKvrHG5Y+cao2C27yn/i9cVs9ElhezmWulBHC8iJTospkEKy
         iL5hdHmsVNCd5WljaANIIU+Vu5GDGdfGpeCdrbqKyKftxqZloMUqhclBEle/LBFKV8Ad
         bo5lQrr+gc/dNXJ/6lnLDTPUVpAuvetpdDtuXu1tdI83yrGSfomkQL7ghNX2r1aTMAdF
         gr4leXt/zf4K+9Soc6gz7UCw0Ez517ZoeiMzzt84dglMzdmiE9+7cJut7xfxdfRbfzJy
         Tr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=VmNejhIxbwZr0QHNkLPt+u87p3b3DQWpfaWDeZvLjj8=;
        b=kbSyUVblV9dRg+5oKG/XhkqvFhTWCFxRS4ens4UBnj0aDystV/Ta+qlWwTxTWl36aj
         toCUXZ8O+9mOK7LCQ4mNzaFaCYMfJ1kwFrBeOeWuNAd0GNpxlyS5o+IkIH84WrwQ4d55
         MfRXuagUSF/92OtMKtGgtnLCr2gVN3RZEW9KCB6qF1V2Or0LesJJaRt5NOcIBhxnwriH
         F7NI4Jytz5sVpFE32wXIhdZAno3RJslX0mWBpW5mNADGY10LD29LQgSh76D3OxxxcDfS
         2Vrtrf2Ifm9gGl1Rd96kQEfZp600gl7v56hc2h/Luz0LEPBCpIEi5RmeMFkKr3W100yn
         T4RA==
X-Gm-Message-State: AOAM5327oKSiaRJLa3Y0Vri9OAdeMdV/MgkVhuX3d05xoJbgkG0kC6GL
        BUwBXaiIGohgMok60TZWz84=
X-Google-Smtp-Source: ABdhPJw2Tqon8noPXohD5vqPyijBWCLfnZbYROAB54pfc6gLrm5TI+5uI/Movq1Ob/NqjSOHd/o8vg==
X-Received: by 2002:a9d:6013:: with SMTP id h19mr15231445otj.262.1603747364234;
        Mon, 26 Oct 2020 14:22:44 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z22sm2934637ooe.21.2020.10.26.14.22.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 14:22:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 26 Oct 2020 14:22:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@mailbox.org>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: add Corsair PSU HID controller driver
Message-ID: <20201026212242.GA108745@roeck-us.net>
References: <20201026152515.GA55313@roeck-us.net>
 <20201026183504.777cd579@monster.powergraphx.local>
 <20201026184151.GA60513@roeck-us.net>
 <20201026202953.505d94e2@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026202953.505d94e2@monster.powergraphx.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 08:29:53PM +0100, Wilken Gottwalt wrote:
> On Mon, 26 Oct 2020 11:41:51 -0700
> Guenter Roeck <linux@roeck-us.net> wrote:
> > I have to admit that it is quite new for me as well, but I find it convenient.
> > And it is kind of odd tht it needs three dots (and it may need spaces before
> > and after the '...').
> 
> Well, the spaces make sense. Without it the syntax would conflict with the
> the float formats ".1" and "1.". Though I looked up at least 5 different
> c/c++ references and it wasn't mentioned in any of them. I often use this
> three dot syntax in c++ variadic template functions, but this is a bit
> different. I wonder if this is gcc specific.
> 
Unlikely, because it is usd in various places and the kernel compiles with
clang.

> Is it okay if I switch my email address in the next version of the patch?
> I mean, is there a best practice for this case? My secure email provider
> insists on encrypted smtp transport and caches the most secure cipher
> encountered and the TLS options for vger.kernel.org changed 20+ hours ago.
> Since then not a single mail sent to vger arrived. You may have noticed it.
> Looks like I have to learn LKML submitting the most hard way. :-D
> 
Ah, that explains why v2 of your patch did not make it into patchwork.

No problem if you change the e-mail address, as long as you keep your name.

Guenter
