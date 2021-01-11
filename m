Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BE42F2020
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391154AbhAKTzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbhAKTzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:55:43 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7CFC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:55:03 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id z5so875496iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=MeTrlceQaSIxNbWjjiMuCwMG9H/K/nyORt0uvbxYR9Y=;
        b=olz0Uz+HvwJKxFUjBalvqcl4r4wtNGHWWi7q+NVnV6xDnbM5geOT1lCgvHwScbbFbX
         XKAXghg2+C5PNSsdIj4olmp5kCfx+H/VZ/Aehg03kvoSm9FQCUKBDJTbfyDOorhf2tSu
         HOIQJV9epnVuzTomX9FRGy16jyWeZZdpY9c5Fixe4KAn9XWcZJak8+hm0GC2LicFqgD1
         qkgo5QSuV5Nzkgl0dvp5jJnpgGQgtgrOo10ECu19hY3/v90iadwCPpY6nPVGRBwioenN
         22AvECZgxRAOJfCLQEHZYzoofF0e/N2hQDLZHsFJdU/0qThjoXV9D27Zf2fUvPfHS7LC
         S4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=MeTrlceQaSIxNbWjjiMuCwMG9H/K/nyORt0uvbxYR9Y=;
        b=Ra6ApAXFMlDOfmtVDZkSepNTliFMC5Xy8y7DT6Jl43zVapVKKXz7YvP+qCz2XPYI5h
         haomIi01sPrkIuas9wV4E71c64GrJ0xKtEShdTKIDdqoPyCsDnp2LpbK/sneSKdF+Y2O
         eeI0MMgfuQ8HALOeCKkqEWrzNjEsHUMwIUpqJ8wQYLe22TjIwKkkHs3ULQ9eymZuxRGK
         cNm1DknThZgHpZHUn9l6J+5LaUKTynfskMOxWi5zEu+Yc4CMkjYIn6SLXZjesFq95bTf
         28KjoC2GV8qvGBN+W6INyaGF14Cdx+jsVPzk5G3biFYuFAzga2a3EM0Mq8OPKf5G8ObG
         nVEg==
X-Gm-Message-State: AOAM532TD4m7e/jaWwV8Jx0AuqtVbUDpQ0IRqMKA/wP/VmvWOyd3CaC/
        2L9+DDOMA4ZKiRkVyE11LJpebg==
X-Google-Smtp-Source: ABdhPJylspAMdLDrXA+gRqXg3ChGd/EI0OEBNJVEMWsZdVzCSJsZlmtrwgjnV6afNiP1PW9ghjdZ+w==
X-Received: by 2002:a02:c98d:: with SMTP id b13mr1203358jap.124.1610394902971;
        Mon, 11 Jan 2021 11:55:02 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id k9sm274110iob.13.2021.01.11.11.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:55:01 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gcc-plugins: fix gcc 11 indigestion with plugins...
In-Reply-To: <202101111148.CDE77FF@keescook>
References: <82487.1609006918@turing-police> <160997457204.3687425.15622431721220616573.b4-ty@chromium.org> <CAMuHMdU1YSODgh_T5RxqUqorveAQiy_-gQbF_SwMEj7gvG25qw@mail.gmail.com> <122278.1610362619@turing-police> <CAMuHMdXR09QdSiziQQ_XuPcJPOca_+mK1jYYHj3VsP_eCu_KbA@mail.gmail.com> <128149.1610368277@turing-police> <20210111133719.w53ad4xnw5yyi2lf@treble>
 <202101111148.CDE77FF@keescook>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1610394899_16026P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Jan 2021 14:55:00 -0500
Message-ID: <155754.1610394900@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1610394899_16026P
Content-Type: text/plain; charset=us-ascii

On Mon, 11 Jan 2021 11:48:32 -0800, Kees Cook said:
> On Mon, Jan 11, 2021 at 07:37:19AM -0600, Josh Poimboeuf wrote:

> > I think putting the flag in a variable (based on call cc-ifversion)
> > should be easy enough, then we can put this little saga behind us and
> > pretend it never happened :-)
>
> Yeah, that seems best. Valdis, can you send a patch for this?

Yep, I'll send one shortly...

--==_Exmh_1610394899_16026P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIUAwUBX/ytEwdmEQWDXROgAQL2YA/3eDzhOmdvrZC6f633Ig4gNOfatCGuMssF
SEWpMHBpY1jtNa3RM8quBA5PjDdxxx5MkZeaSbNTqb9oTMMMAU3ENN+eTCbSnPCm
x80B/88cmC/rhZ8pvb8PERQedRftmyQKZjBMORsZ3V/7ihZTD0LWXUOBsa33Cq0h
mpQY2K1YXL7Cvzcamf2mmO7hBZ0XotF8k6FK2Twv5BhYzYygNWUIYaIz3etTURo5
s6uXcgMiYLAvY0+HFhnaa835ShB4vK2yM6UQWo1iOSY2U7rwzMAQiMxjtadI9+p5
UQWSsZCOHP+q/WVzD3wp2tbR4pnyrupD4JpBje5mZA10DUTBLKOciU55vNDIolNL
4J8urK/KBHZzsr6G5eC30RQKhRLtE+gwtNFL0Gbz46jg8EAnp6FuBpe4FE/HhHFf
AVUf5aT468okYdXcRJc/24A4NT4yiHpC6b/P5Fo2pjJJ50YsIfVFKyrZC/lOvQUO
+i6CoN0VHuD5CXPg3K66PRy5xGrQuj11J9Fq27QRWwEG6ojx3UwAiBAJ3XSvRTWD
IfgOr/bZua8MAchyGHNKTaSvGMG14in8DPx4qHs0TldpCTLOLZjKMpGspkkma9tz
FHxnTkvYw/0+RKPRBv0ABG2Ge3T+L9d+fjyYNJWRFK2d+J1P9w6Y4vZSAKeF0oQa
/CP0RbOgkA==
=oXFu
-----END PGP SIGNATURE-----

--==_Exmh_1610394899_16026P--
