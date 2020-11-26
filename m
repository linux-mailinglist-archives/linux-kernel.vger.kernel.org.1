Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7E92C50E6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 10:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389112AbgKZJH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 04:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgKZJH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:07:57 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2871BC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 01:07:57 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id lt17so1856170ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 01:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CseN3BiBpJYn6k+hUUx2TxuA3gS6VM1QHXLDLxQNUzc=;
        b=DKbtAJh9VwlenVHUVkhSbBh1/F+bvxi98j5MDApJdOuyTBUVa1fbC/y8CDC2puEVcb
         vTPGAtouiJ3rCtkvpieDGvnNaHyO3mMH3rd3mhJN+lRvon6I+HNLoxgPKZZeTNgZszYD
         KH03h+gjP41salwzxpqnr+g61GNGPiJvB9QaOlC5oLcCWr6EowifuPBmrrH451vSOHwc
         P1OIDjPdWYtIfS3ltjfn8M2DcinBvHPVRTdEn8y9c7HS3W6h+/M3L/pDvgSf6r7a/cE7
         WESmI0OGCMmqZOpBoIT3v301wQ43obqrw/Kbbb3etSCi6ZurfLt/eIjWdX1uFPTQtMm6
         TxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=CseN3BiBpJYn6k+hUUx2TxuA3gS6VM1QHXLDLxQNUzc=;
        b=J4j4s5W+AiEZzeYJiEKS1YbL9bsgQYiXE8B85zxcth5ZH99c49tDM9Q22jXcSYA2P9
         QIPkyfEd26OJJESBnu2YZkTUYrRbxBUVnQi7LrZkpaAJuYSxYqJ7L/YRPer3JxtFvM+A
         HSckmZW67rWJWRWURKzAHWYdt+Smp6AINyZv8sm6Le33U2pDxavITvMn5q9bmvG33cYv
         peVn/aBQhTzMv35kIK/v3srew/5dVgy9PL3oSs8lgutLjATb4PzaffVd9QOP9fAyguFS
         Cd2dFkVp+psvn2AYZTbP4Tp6ncilSfdjuRI6OtfQMjjtndDGYYxtUhaQlcJK4/GD6nxf
         Bw3g==
X-Gm-Message-State: AOAM533GcemwyKeA9XfFWHWCHg6cqsxSuFrK7dYiflrYjnm3Sys5FF41
        5KoQIE07i7eVHl2ANJQW1lnSXN7HJ2X+RmICM9c=
X-Google-Smtp-Source: ABdhPJz7avU6385A4IlBu2HuMYoGq49r96Bup8GK3GwZIUgFa++yDCj7bxoY6bwDlRm7rw2MRjhRGhiRe5Je6JaQiHM=
X-Received: by 2002:a17:906:dbd6:: with SMTP id yc22mr1837823ejb.252.1606381673418;
 Thu, 26 Nov 2020 01:07:53 -0800 (PST)
MIME-Version: 1.0
Reply-To: paulwagne7@gmail.com
Sender: shivamgupta7972@gmail.com
Received: by 2002:ab4:a12b:0:0:0:0:0 with HTTP; Thu, 26 Nov 2020 01:07:52
 -0800 (PST)
From:   Paul Wagner <pw9076424@gmail.com>
Date:   Thu, 26 Nov 2020 10:07:52 +0100
X-Google-Sender-Auth: WSjY_XPq25ZsITNir93Dt_xyzOQ
Message-ID: <CAA25XNE-R7zzghR1rpOxF-opHOLvkS6Y3qnGs_fboEVrPNOZFA@mail.gmail.com>
Subject: =?UTF-8?B?U2Now7ZuZW4gVGFn?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,

Mein Name ist Paul Wagner, ein Familienanwalt des verstorbenen Herrn
Thomas. Ich habe einen Vorschlag f=C3=BCr Sie bez=C3=BCglich meines verstor=
benen
Mandanten Thomas . Bitte schreiben Sie mir f=C3=BCr weitere Einzelheiten
zur=C3=BCck.

Gr=C3=BC=C3=9Fe
Paul Wagner
