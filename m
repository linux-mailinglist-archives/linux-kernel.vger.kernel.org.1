Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1127721373C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 11:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgGCJIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 05:08:13 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:34943 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCJIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:08:12 -0400
Date:   Fri, 03 Jul 2020 09:08:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1593767290;
        bh=50Eb/Y0e53WKbt5ES2NNmH1DcrZiBdBBPSjrZRHLhw4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=baOJ/PJAnC9mWvp2rRn7RZGSJ7x8stNUldq45n/lekJ3Xk2iJQMjhL7/3qSoXC1j+
         kO2G4Oamcvt5hEAE4qISxXVg2Hf788uP13ilRKuw4Q7jwcWvGZRqgEzr+6fT7pZA9Y
         tKJPDix3+HTUSS/rw0rMr89vVzymMQ3GrF3MgCsU=
To:     Neil Armstrong <narmstrong@baylibre.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "jianxin.pan@amlogic.com" <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v9 1/6] drm/fourcc: Add modifier definitions for describing Amlogic Video Framebuffer Compression
Message-ID: <RRm1buCbVQy5uesUHZhz8cPiCZfllmj0r1HzM7OoBmJBNMo9tuRfs3ju0iFnlPfDqECFq0tVj10h7bboBat7i619uNUN06HbwswBvYaPWMM=@emersion.fr>
In-Reply-To: <20200703080728.25207-2-narmstrong@baylibre.com>
References: <20200703080728.25207-1-narmstrong@baylibre.com> <20200703080728.25207-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the update!

The driver should also disallow importing a AMLOGIC_FBC_LAYOUT_SCATTER
DMA-BUF from another device, but I guess this is clear enough ("not
transferrable between Amlogic SoCs").

From a user-space PoV:

Acked-by: Simon Ser <contact@emersion.fr>
