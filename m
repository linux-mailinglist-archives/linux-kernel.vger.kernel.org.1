Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7ABF2E2265
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 23:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgLWWU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 17:20:57 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:24497 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgLWWU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 17:20:56 -0500
Date:   Wed, 23 Dec 2020 22:20:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1608762014;
        bh=EK/kRuktdtjfQl45kjvt1uNuLM2wx6A+3pLRg30o7AI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=HQBB7c4AzpvPt+F0PSqxFQgiWKTPWDOo2evV4XsOQYMJf3Cxfd/j6F1dkf+Q8tpsH
         QgUOKzxBfeNBFvKU/kzeO+6LcZL7j6dGJNR89FR87faPSBijOKDdG9RpoORiB90Iu6
         W7/TBErmSmocrT3LO4fW56DkeRM1T+xCMTgV03X26cKEvwoK8xHVzqtXqklQLNIxoX
         +r4YGNcJ7OxghwrWKuZcSU/L/Bg9j62uLUDBxmRKdiccPmrvQw7YCcH1dUKy5OwxoJ
         bY8aWa6WRRlDEM+xY9YxcRRT666H/BfDhri4m9s06fwqIwUvR/Vp25CEvaQFD/nT2k
         MKScipIHD5S0g==
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v8 4/4] NOTFORMERGE: drm/logicvc: Add plane colorkey support
Message-ID: <oDsOkjfTYKa11LxfNy4LBLqutkVidfFn8--tjQPZj4w9gzCYNTOFglHqxXohsrYqTJ4uDv2xgJNKXPHzgAsACGnCkbKQis95SScGucOb1PI=@emersion.fr>
In-Reply-To: <20201223212947.160565-5-paul.kocialkowski@bootlin.com>
References: <20201223212947.160565-1-paul.kocialkowski@bootlin.com> <20201223212947.160565-5-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nouveau already has something for colorkey:
https://drmdb.emersion.fr/properties/4008636142/colorkey

I know this is marked "not for merge", but it would be nice to discuss
with them and come up with a standardized property.
