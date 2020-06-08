Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8962D1F1E51
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 19:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbgFHR3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 13:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730728AbgFHR3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:29:12 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61144C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 10:29:12 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id y9so8729851qvs.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 10:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=pVi02/1lSeutlFv8vPsavfs6kZD+K668tKO9td/zctd0JVkvceAdDN7y1P5yT2oU22
         LALwYXrZ91X7dBp8yYWkEcs9c68YiLd5wvq+/vXFtuid7jb8ZqwxOsj8rm8B+hg58YpM
         2rGDi43naEm4afX+jL08TetTQT96qbTLwuoZIphKG1NYBRM2IbH2O0t63R/PMMFMW6hz
         Atpj/bmDaQl2dZDY6jQKr5470UEMrYlg1yZwF5K0UMTiueNWD4dxVk3Y8qdByY+/NnCQ
         PPfJNjQRxwioTMr8fugzq4HDBxPzJYPZTPuVxD9c9i8m2tCCNDSTyUwS8EgLjbXquFJ3
         xE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=OY2JCHQXnVoF9ugLLquZ/fzPrgc4cdtkKR3Xp0MXPiYKUpXbekwMDKi0tx1719+EdY
         rOMoknvRN2F7ZaEkWUP908bnva8LwNnIBDy+gEw5+wYLYypRV9Ac22dfdeyP+OgCJ1b3
         7ZyCuyOtWqE7y2z16qojb24/LxL73fkIUsOBMOROxUFMVODLwI5THGeX4wDhOrLbZGgw
         sPokLOohWUSv3CLaLoZ0jyNedyls48FD3D+7jRFFteqfJWi2qH4jE4TG6Gd2JwrGoCg5
         V4h5GTjEGgL7wa2Ba+l3lmTDbBhnpshE+X92yjgI5O1+WFovxzmTXRWiFGHi0RuH6uHp
         J/2w==
X-Gm-Message-State: AOAM532qysKhU8rdy8SBpE5xEjeAM3exTcmb5V2j1qgfyFeHqi03wCnU
        3hfUMXETo8FXuYEGu5PvuXoTtdjwsi9z4OuuV9w=
X-Google-Smtp-Source: ABdhPJx2SGlrMJPeei7WDVMpMHRUBxTpgYW7RBoU3rtutX7XVWdYLRqSo6eKKDQwL2GaEC5aFM5k+F4Nsn+xZ6V+YV0=
X-Received: by 2002:ad4:46af:: with SMTP id br15mr10211701qvb.178.1591637351458;
 Mon, 08 Jun 2020 10:29:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:1926:0:0:0:0 with HTTP; Mon, 8 Jun 2020 10:29:11
 -0700 (PDT)
Reply-To: annie30luvly@outlook.com
From:   Annie <brainmorgan048@gmail.com>
Date:   Mon, 8 Jun 2020 17:29:11 +0000
Message-ID: <CAG-WmJEL2pQR1eK8oEmEJq6Eb-jUZmvMJ8LZcWMQ-1Kfhqb4iA@mail.gmail.com>
Subject: =?UTF-8?Q?P=C3=ABrsh=C3=ABndetje_e_dashur_ju_lutem_m=C3=AB_kontaktoni_tani?=
        =?UTF-8?Q?_kam_di=C3=A7ka_shum=C3=AB_t=C3=AB_r=C3=ABnd=C3=ABsishme_p=C3=ABr_t=C3=AB_diskutuar_me_j?=
        =?UTF-8?Q?u_Annie?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


