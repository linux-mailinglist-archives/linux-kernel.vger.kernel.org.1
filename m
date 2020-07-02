Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E37211FB1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 11:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGBJXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 05:23:20 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:21837 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgGBJXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:23:20 -0400
Date:   Thu, 02 Jul 2020 09:23:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1593681797;
        bh=EJT6kTJtM5+ySWMxszu/DdczoOnQv320IEAHL8sPdNc=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=IkR8+okl82HMk6lp5WbqQwPg9K6uTi/dg5MMRhR4Z/MD+mZZPmbDoyFVQR0AO5EG/
         VZLs2hswaYP7yUFHs9BiS8G17VKFJd2qzNBVUPjYzKAopjWi4E7QYG2hCTYXRHXMQG
         MyjLWVdZt2RZNMAsei9VKX8pZOHdsWdolpxoD+0M=
To:     Neil Armstrong <narmstrong@baylibre.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "jianxin.pan@amlogic.com" <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v8 1/6] drm/fourcc: Add modifier definitions for describing Amlogic Video Framebuffer Compression
Message-ID: <8cBfZpkc4pHBLhihlvJMD_Hq1DEsNRcSY4Y8JaGwklMWcxiYzUMVEx7wH9f_DuCBMVUhXvOR0PcHVslILtKI2wdw79Nfih0N3VnrxfMQd08=@emersion.fr>
In-Reply-To: <20200702074759.32356-2-narmstrong@baylibre.com>
References: <20200702074759.32356-1-narmstrong@baylibre.com> <20200702074759.32356-2-narmstrong@baylibre.com>
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

On Thursday, July 2, 2020 9:47 AM, Neil Armstrong <narmstrong@baylibre.com>=
 wrote:

> Finally is also adds the Scatter Memory layout, meaning the header contai=
ns IOMMU
> references to the compressed frames content to optimize memory access
> and layout.
>
> In this mode, only the header memory address is needed, thus the content
> memory organization is tied to the current producer execution and cannot
> be saved/dumped neither transferrable between Amlogic SoCs supporting thi=
s
> modifier.

Still not sure how to handle this one, since this breaks fundamental
assumptions about modifiers.
