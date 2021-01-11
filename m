Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49EA2F10A7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbhAKK5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhAKK5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:57:42 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79770C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 02:57:02 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id e7so17894274ile.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 02:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=nqIQLzwGrtcxFYKZkj0z+xis73875duwqiCkk4GOBKo=;
        b=qwU3ww8Ca+JbeHLbpyR5qvDQUkr+xDQFsi1Kh8OWii/0LXK6aGP5G2QhJJnKBw8fPD
         L0tALbZzx0uuIQUMc/GoJQka9EAnNz+q0Ilbc+pagNWAW4OZzC+3jZPNV856Bd/u/v9y
         MvPiyEWf0RFAacRtxT1GptvJYJGgQ/us8qBAmJwYmUz91NZ/FJt2akJ1X6qMRP/D5LLw
         eez2DupxSSVbZxThdvEd+aicIKCFTYw2cxzIVGnNSZBVYlc9esQTZvnn1QE4XfmhORl2
         tu0bFTGa4n8L1r1LX9NMCONHxAj32MBbpTkBPVJJ4YL9nFgn6VzjE1GOAv/zoYeh58Qr
         ex4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=nqIQLzwGrtcxFYKZkj0z+xis73875duwqiCkk4GOBKo=;
        b=CNqHFEMKhr+YuMUGAzlpz1d8hrVwxlOvsl8dUeXlO9IYjtlAEDHV2tE3MG5JFO4Bhn
         gjRx1tURm/lCNzeaSAJNEBp2OmlY/xl29o6IrifThxTwbESmnbk37odaoLWMGNjI0ZU1
         Lfky68zfpm8evM/SKojXBb8WfkFg2CNdnUwGaB9qfpUhkn3fIE35JK11RzjWI94tSjFz
         oZZKu8xxcHv4Ld3DXXW0oroXquz5qr7/ofRY3oF1fA8fFsDayWbm3aPIBJGc2qUujOhB
         QzpTdd2b5m8AtVA7v5AiFMF/MRvEGfaHNc2Ddee7sdBBOd6eCzfQAacojC/2kg1Dw+cj
         QGeQ==
X-Gm-Message-State: AOAM531Vm6gYDcL+BCASRsXo8x+2qgmw8aqSbX5/jc8Zr20EUPusa/gU
        wBGfnLtN7zDM6N/pgmBz6lZSTA==
X-Google-Smtp-Source: ABdhPJyLqDmoq/j3K+zEcicUCA3OcphDj/miOd/cMpvIberW98MdC+NQKuFu3qtilzEzVldbl9oGtg==
X-Received: by 2002:a92:5802:: with SMTP id m2mr14548739ilb.271.1610362621835;
        Mon, 11 Jan 2021 02:57:01 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id b12sm15118172ilc.21.2021.01.11.02.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 02:57:00 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] gcc-plugins: fix gcc 11 indigestion with plugins...
In-Reply-To: <CAMuHMdU1YSODgh_T5RxqUqorveAQiy_-gQbF_SwMEj7gvG25qw@mail.gmail.com>
References: <82487.1609006918@turing-police> <160997457204.3687425.15622431721220616573.b4-ty@chromium.org>
 <CAMuHMdU1YSODgh_T5RxqUqorveAQiy_-gQbF_SwMEj7gvG25qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1610362618_16026P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Jan 2021 05:56:59 -0500
Message-ID: <122278.1610362619@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1610362618_16026P
Content-Type: text/plain; charset=us-ascii

On Mon, 11 Jan 2021 10:47:23 +0100, Geert Uytterhoeven said:

> I guess this is the cause of the new "warning: invalid suffix on
> literal; C++11 requires a space between literal and string macro
> [-Wliteral-suffix]" with gcc 4.9 or 5.4?

Well, we fixed a #error, and picked up a warning.  That's progress. ;)

It's probably related. I'm just having a hard time understanding why 4.9 and 5.4
whine about the lack of a space, while 8.3 and 11 didn't complain...

I'll see if I can cook up a patch that newer gcc are still happy with.  You able
to easily test with 4.9 or 5.4?




--==_Exmh_1610362618_16026P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBX/wu+QdmEQWDXROgAQJOIBAAtkQZFN6DBq0ke31o+qNydBx9V66q5WT1
Rn3IhqLAePAT4VudG8e5IjYOa23aHMy2OEFiPZE1Dl8QqmSCLcYl5C/R9XjQq89A
jjtpSCK2vqxxeBnxRMHbfXj9cZFGykEO2+KDea/LV+m11j9k2pN8OLcLDq8sn1/h
OdLoHrtXNCRuUcfdkfXDuSMBHG1uZ5xqakZRhTr13rp0vIo7o9L6MbbzYia0VkiT
HTM4r5hJyZgNfz4+J/I3zTj4dC8GmpW31CdoSrmtc2sWgUySYKNaumyELQqCWhtc
0scAbs5gPFWTdTlpUSspVXHjvaxcm2Df/s6r65MkOAvqioV0anPU1kiuVqswcU9z
waDb60JomhspqesVAmt2x6dCsrYEBXV7TWDHyEgAcjCDMZvz5bvdMPQukxyimqYR
mJdH1hj9jJxBSQMf6J2v+bgz7SLapburc/AeaD72b8srL4Rhnx1XHPOqa1J74EJW
OeWPYnOd2R640SgNEpCR4sZ1TDWeFOvhOPkwvuInVNAwWUQsmxZDJiMXFfxMUDCk
15QJhiIS6Bepw4s4oOBnJAL5489IPzdc4IRe5R71IkQzY/I64nt6sAD2wQOwW6dK
A3jCSC9UUkl7BrorfK8sl/MhN7BVbkqFayua7c7Vfwt9HGjhNIgPYqyaI40VZPti
W4gjymofSp0=
=p7uY
-----END PGP SIGNATURE-----

--==_Exmh_1610362618_16026P--
