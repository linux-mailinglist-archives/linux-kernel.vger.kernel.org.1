Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A0C303BC8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392542AbhAZLhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391364AbhAZKWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:22:02 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6A2C061573
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:21:22 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id g3so9549005plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=rCcoEc6WXLZHkKSRG6Dp64pc856U9Bay4SXV/yz5TDc=;
        b=vLCujadwwLLU6kFobsFVsN1/qz/gWVaXbur+czz+adfOuha7JgaL86ubL4kL27me5/
         QVf8UFDpNjm/6/Z/sA2yYiFrEzBzsHzh0/UbqOD2B2E3S40JsasRuVQjKV8Gi3qiQBLv
         thIuthMbXW48iuCy4EcYHoxxtzId5qsIzhdIYUQ/A5wRDkUlCjpvy470wxcm9mLAwBpF
         jbhCndmERM0ocsiv0TJQ+TsZad4F4u06MFb6sF2ccPoUZbwsw5iuXv/QREe5Xad3VZV8
         SWptDf/BCOzVqYuO+qVvuVyHxn6yFmPAbAqfr/4ccKAhShoY8H+n7YXxyjV1HGwMqUEX
         t8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=rCcoEc6WXLZHkKSRG6Dp64pc856U9Bay4SXV/yz5TDc=;
        b=MTBYOz3c6vL+0FFtp+NPY10P25ELNloPeyUILik2+4mlzzPAh97UxTE9Dvc7kT3nWg
         EeojX+17L63VTXQ5vG3ADbDMt6kQ7wwtoB08uYul+o4JKNVllAsmmg6AkFmvLGs9RTDX
         wIbGW9h8mQA50P7p4ej0k8pz792RKypfuATWTC/GhZ7vwkyUhGrXTbTj+JhlufHZ5hYa
         VxPy6FmMrP3qe2HevMHsZE8cnfratVJnos5zNRIcDD9hh7wmdapBUXRYr2D06BrTYFNM
         ECw+D7isiTz7pRat3x9q3qWQHX3YvSk2wo9v3KK9d0yiklvFSyRg2bVTj5BP4Mfy56/Q
         B4Ng==
X-Gm-Message-State: AOAM533xvfpy0a3LkBokg5OWN2aFxtfFXDpRxvMbQKVAj/b/qyHCp4iJ
        7KeN/spT5EPV4Te6GysObqI=
X-Google-Smtp-Source: ABdhPJxNCe+IzIn6LqnOc/P/GGzLLVXChWeOUG8maLaQds+/6qqf/ZMFVrvuza+JhtmKOkJChCA6pQ==
X-Received: by 2002:a17:90a:e00f:: with SMTP id u15mr5300446pjy.130.1611656481685;
        Tue, 26 Jan 2021 02:21:21 -0800 (PST)
Received: from localhost (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id m27sm18930768pgn.62.2021.01.26.02.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 02:21:21 -0800 (PST)
Date:   Tue, 26 Jan 2021 20:21:16 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 11/23] powerpc/syscall: Rename syscall_64.c into
 syscall.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1611585031.git.christophe.leroy@csgroup.eu>
        <ff9dd4accdc897013594768833d54444e4823bf9.1611585031.git.christophe.leroy@csgroup.eu>
In-Reply-To: <ff9dd4accdc897013594768833d54444e4823bf9.1611585031.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1611656343.yaxha7r2q4.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of January 26, 2021 12:48 am:
> syscall_64.c will be reused almost as is for PPC32.
>=20
> Rename it syscall.c

Could you rename it to interrupt.c instead? A system call is an=20
interrupt, and the file now also has code to return from other
interrupts as well, and it matches the new asm/interrupt.h from
the interrupts series.

Thanks,
Nick
