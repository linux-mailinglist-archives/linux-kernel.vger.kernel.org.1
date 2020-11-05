Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189C72A8464
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbgKEREX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgKEREX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:04:23 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D24C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 09:04:21 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id e7so1828866pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 09:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=microgate-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AiRUvyKwcp21/iTOlatjBOFIvzQH7MDgnHUMinEwyFA=;
        b=zJkC8utyCvLJqhr9LnyzCmVEJmkhwpjjXSOKpeDRyW9vH4Tg+uDoeqqr3sPO/Fs9yC
         fQPQe6LUlBRvQaAnkRoqwYbSyyy/HOP6vh3RhKhCiHLpnq1rqtH1OfahpJHaOzplCEUX
         9rj+6teQfPW8j3BFLPONX6qxZPNYbi4ARsjyGry071275dQYWotQdjdknXtcLD3U0jdJ
         PqnQINs9nXrGG6XaZ3kPH1VJrAWTfdgJQucN/BzrPR+GbDo/76DNeCCOzcjinzjQDf/m
         YE8WvHkL9HmrjyqMFxFsAvmVrs3hmdAMm6Zg+qdBgDrZt57Gavp1TXDpXFX48fBQ5Gg+
         oBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=AiRUvyKwcp21/iTOlatjBOFIvzQH7MDgnHUMinEwyFA=;
        b=JRp+CTC/dvVlBS2Zv9wEkYAWc18eK4l9ds+EqIqJYC7/zRlNKjqgxfGJ++kIitXx5j
         OVewuUW7QNYf74W/BylB/0kX4CUyc/6UviCEw27OK2MGVoegfl7lWJMlVTWUJjAi1+lj
         3xeicigfXnvXP6RPTZidgG9kt8YCWqlfo5jPybFVRHQ0kCHXfNI+cIMpEkU0nnr/qxll
         CclUcGmHwBCsg5755Cg/AefzI8RKl3eVMfEKRkAYSV1ix3juOjottojJryBQQE8ilQZl
         F4oGxP1Dg2krZw+B/BIXXCKRU8UJ8r/ceLU+t4BboI18SkPZqyOBxmkzIxwlkfmRf6+a
         8eKA==
X-Gm-Message-State: AOAM533EoV6HwoT3fhDj6tfkjMySVz5H43z6HproaEUpuifVgvHWrfxz
        vP/MDcbo81w663MGrv8mO7Zn3w==
X-Google-Smtp-Source: ABdhPJxNja1n/hMUsb6d7miai/EwlVxjk1YPBVcn5lPqtE2ozo650PVaZhKGDLtOvnFwqgEUfN+k9w==
X-Received: by 2002:a63:e74a:: with SMTP id j10mr3378850pgk.208.1604595861068;
        Thu, 05 Nov 2020 09:04:21 -0800 (PST)
Received: from [192.168.1.77] (c-208-53-111-167.customer.broadstripe.net. [208.53.111.167])
        by smtp.gmail.com with ESMTPSA id i26sm3331174pfq.148.2020.11.05.09.04.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 09:04:20 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.15\))
Subject: Re: [PATCH 27/36] tty: synclinkmp: Mark never checked 'readval' as
 __always_unused
From:   Paul Fulghum <paulkf@microgate.com>
In-Reply-To: <54D08301-C89F-4AEB-B9A0-6CED6D5EEDA6@microgate.com>
Date:   Thu, 5 Nov 2020 09:04:18 -0800
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7C858DBE-A5A1-4027-A44B-85F6AE3AE579@microgate.com>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-28-lee.jones@linaro.org>
 <0a4043ee-dad5-7691-8c67-db73d3c12f52@kernel.org>
 <20201105084341.GZ4488@dell>
 <a95f8d0d-28ef-7351-cdbb-7da5ad8aa9ad@kernel.org>
 <6515b9ff5a9343f5a713e337f41450cc@AcuMS.aculab.com>
 <20201105112728.GJ4488@dell>
 <54D08301-C89F-4AEB-B9A0-6CED6D5EEDA6@microgate.com>
To:     Lee Jones <lee.jones@linaro.org>
X-Mailer: Apple Mail (2.3445.104.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Another candidate for removal is drivers/char/pcmcia/synclink_cs.c

Everything I said about synclink.c/synclinkmp.c is true of that as well: =
the hardware stopped being manufactured decades ago and is not available =
for testing. The possibility of these cards still being =
around/functional for use with the latest kernel is about zero.

If Lee Jones does wants to add that to his patch, great. If not then I =
can do so.

(I resent this message in plain text after it was rejected for HTML, =
sorry if anyone got a duplicate.)


> On Nov 5, 2020, at 3:27 AM, Lee Jones <lee.jones@linaro.org> wrote:
>=20
> Will post the removal patches when my tests finish.
