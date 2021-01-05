Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504D72EB570
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 23:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbhAEWge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 17:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbhAEWge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:36:34 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C91C06179A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 14:35:38 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id g3so539644plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 14:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3Wsohv7UtGHD8fUFo782sUW7FfrX1llj4qPmo5np5c=;
        b=PVCg8LSFf2dm9SNMiuqSsBQIOUJcnf+UW7k+5JeH7EIUUj3OzWyI7vtRUxlXtxIBU+
         wB7SZOz6mfhKhAXkVLqyglotoAvoeVv+9QgMc8D63uGQr8+zGL7QopQ3ecbfqL94qPw3
         TmOgBLf49K4v1/vMrqphfhNLbo+gcAJwVkF3XomKAo/2K8lcmFlUBco0B/EvbIkDxiUC
         7Ovf0afVPGYjrT9POgVKO8KgHFQjsmlLuAo9ECFkasayleqYSWq25xuyGikcfJcQWArL
         wfpy6guMfDBv5XLzEGAUzjBfRt6oQwrIkgs2mPBURtd6VFNP1LChVzQaX8IgSybDuA1b
         3Jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3Wsohv7UtGHD8fUFo782sUW7FfrX1llj4qPmo5np5c=;
        b=UhaPgWH8DWtAEmKps3lTfYuovC3y3M4x1qRYD8Jh4ZEPHya0c8GnQg0HWR3vzJdbrb
         0Z0yvcT70+dzQXD/4N5M+ZH4TqkLGV7X7YwEBJjxR8FBQn4RLg5tMvyKKLcEVOXSe6cE
         szyfp9LZkpaVXqX00BPCVFMl898+Pmjk5yeeDlhSJgcZfMjouztww5T6ZFrE1rw+JTp8
         O3ypTNXEpTV7sBVqlOQEhHo0c399CK0LBLFiMeFBI2Xjh5/jeq+Y8WNskeGJxKoklAtZ
         qHqpZllh5OTkQa6syBCdEKdWsB/1ad4egolxdx02BgIq6tAypbeinsOQnde6dC1SXv+t
         8sbQ==
X-Gm-Message-State: AOAM530HiewVbVvULWZIVSHDD3IUpLLCfmaNJ70dXFH6fDGUwcDX5ckx
        MkGANjRX9SckV6hEBpzk5NA=
X-Google-Smtp-Source: ABdhPJwkR38J1HtHKXQpAmlJgGce4mESgrXn/gPq7ZFQpubewHzALlt8tCYYVPb2AoHgv5tbIPR2Qg==
X-Received: by 2002:a17:90a:7844:: with SMTP id y4mr1332129pjl.68.1609886136322;
        Tue, 05 Jan 2021 14:35:36 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g7sm219146pjm.46.2021.01.05.14.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 14:35:35 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Include bcm2835 subsequents into search
Date:   Tue,  5 Jan 2021 14:35:29 -0800
Message-Id: <20210105223529.1160176-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1609676675-5361-1-git-send-email-stefan.wahren@i2se.com>
References: <1609676675-5361-1-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  3 Jan 2021 13:24:35 +0100, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Change the bcm2835 maintainer info in order to handle subsequent SoCs.
> After this get_maintainers.pl provides the proper maintainers for
> irqchip-bcm2836.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---

Applied to maintainers/next, thanks!
--
Florian
