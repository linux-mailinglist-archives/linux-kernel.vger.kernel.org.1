Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9592C56EA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 15:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390307AbgKZOSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 09:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390078AbgKZOSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:18:11 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856A4C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:18:11 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id y197so1634166qkb.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 06:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=R6BrEWkteQvQbjsApcd3N42+tWQEuLbo/lT+UxHp8d0=;
        b=k29quvvY9G5+WStu6ovANfxwBJG+sS86f9VTW9pGp+Jrw71aymFRgPnssA8K0F8SIq
         s6KtUC9OqNqOMgxqXE/UxSjCO245QvGAWF13Xk+VSZcuJPw842s6syijNZmGp5ukMOlU
         UQqQSWepCmILk+DycLz7OmhUHjtcxYfzgX88oYN4VKOeIccVUvUjclqFeRPH0HI1X1Ib
         DiYUtd7Mg0AsKZmQCi4Kfd/jsqbctH+HmeQCte8SnHCxKl0GVUp/OrFH6HSKqNJ40qUj
         jwwjtF9ILIWOC4cOsBqqn+fJnfXj6U2B2VKAC5eYezCI5/y89fuw2PqyWee/OX+NSeRP
         vOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=R6BrEWkteQvQbjsApcd3N42+tWQEuLbo/lT+UxHp8d0=;
        b=R/cOhOX0joX8pVCB02Vct7S9nRRpdux5QwLqoFn6x3klpwuWWaJA3vx5LYu9VzmF/H
         U+YFSQUkshwAo+J93iITEBS50oYDLne2jQ228tISDwGHgalrp3CwNfJ5mjxUt9faEjNA
         ysarBfToTzqYaLXONYaBwqRW6AB29cWFeU9i2gQh7tsRcN3Uemd53ATEkdmz/s5S7FGX
         o66r2iOgwBfPJdBWJRzetjb2aQ1qC/vODdQqY8fiSEex93mu2g9xXtM4N9vHhB52eXx3
         iqNNXxVAhzP/IRYWhUBrwucBYKw76in/ujYMVx/YNzbAU0/Qxp32yf+mV5icB7UyPkN3
         RUdw==
X-Gm-Message-State: AOAM5303g646m9vk+xoaM7SNWEAtlgtngBEymm2j/GZZB+EMvuj8qrE9
        muWxfWFXxBtg0p5o5tqBqwr5UIg7YHbyGQ==
X-Google-Smtp-Source: ABdhPJwZ/+zR5x35WU+uEgCh82/pnPI/abEvdP00dApAKd2rCmA1RycQJmvoYAGMDMunLbg45q8nnQ==
X-Received: by 2002:a37:5444:: with SMTP id i65mr1818763qkb.263.1606400290743;
        Thu, 26 Nov 2020 06:18:10 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id n125sm2636977qkd.85.2020.11.26.06.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 06:18:09 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: linux-next 20201126 - build error on arm allmodconfig
In-Reply-To: <20201126141429.GL1551@shell.armlinux.org.uk>
References: <24105.1606397102@turing-police>
 <20201126141429.GL1551@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1606400287_2385P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Nov 2020 09:18:08 -0500
Message-ID: <27841.1606400288@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1606400287_2385P
Content-Type: text/plain; charset=us-ascii

On Thu, 26 Nov 2020 14:14:29 +0000, Russell King - ARM Linux admin said:

> The real answer is for asm/kasan.h to include linux/linkage.h

OK... I'll cook up the patch.

--==_Exmh_1606400287_2385P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBX7+5HwdmEQWDXROgAQJMKA//eov2gfD2DBYzF0uuV+ihRR8rhFilRQYh
5/GbflGzyksBKdpX3muKRi4MCJ/6TTvBAJmwcXUNtxCdV9Bv+OR49BmAdouPT5My
3+SA8KPA6Gx4kzBsYHF9TXRfqPT0ocB48rLdr2Nl9UiCXgcRu7Cchc9slJJfQ5gJ
Cst8Iw1QMm2T4Ez4BOyz4Mb7qaCz0obRz1OSmZCN00NKAdBxwtd2h87wFCbIRnB2
1X0jZXAj/rZ5tFPFNIzR9DWHxV+WbLlBHehSdpp/xrS/1G0t28lrKd4AKoXzKEpK
BiAmQr3WTLok25FS6OUkcRBF1PKOEcAac5GxPhafnHvZxVIPgz9C1JZ0meJb5adj
S6Q7br2Rldsc7Ug9jJdGi3o6ns2gjjKQTY2nSRrAkySBtv+zgxgX7tjiQHSCJQm8
GUFnGSdWX7ht9OUrUUaAKBjo9kqDIhHQTNGWLe/iNmGkoYjYDihqolATHbWE6r3v
pAbzTKc5phxnByP/R4MhubaBQZwkguNafOuqtPpiMI74rzeUMSHfeRb3e/ku2BJV
pIALKrQqKA4QXrGgwpsclW+zv4zkeV0tc7gVQv6uZqwHU2a1UIi7Q4Nzv+IWhaww
XrCD7RUUL8RuJGshi/4L1JDG4JUrJJVVKDhhQxOMvVnkQmfDtcXjBtqWaZp6p73L
93xqF71a4Lc=
=nqtk
-----END PGP SIGNATURE-----

--==_Exmh_1606400287_2385P--
