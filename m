Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BA81A6F56
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 00:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389678AbgDMWcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 18:32:53 -0400
Received: from mail1.protonmail.ch ([185.70.40.18]:50328 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389641AbgDMWcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 18:32:52 -0400
Date:   Mon, 13 Apr 2020 22:32:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1586817170;
        bh=seUGhoZepOTnyOHLE3h+4/e4jZLc55h9FX57lknv1A0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=TU1GJV8XzK9LYQ8Pa65IahPFwirwI2nMYSb8vXtvgfkxI7nBzdDrRJdtCIkqn5q6w
         6EN8wDVhb1ApjR1INNEAinkN+gUgLfU5hI4rfdpkrOUSQ8TUUSiGtfKZfSfQkrxXCa
         rar5mDd027U13HpPbGUAU1GjONIxHZq8mdspJaEA=
To:     Yussuf Khalil <dev@pp3345.net>
From:   Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 2/5] drm: Add "RGB quantization range" connector property
Message-ID: <k5qjrDz46MIiTOYsgNWoplNnN6Y2wuMP9iHqOw555BtThDyBETAFd7JNbVK3bi-FUsOu9Gzx9Ibj3p8iLpwc9yAPiOBl-t_5e9tw48e4dFw=@emersion.fr>
In-Reply-To: <20200413214024.46500-3-dev@pp3345.net>
References: <20200413214024.46500-1-dev@pp3345.net>
 <20200413214024.46500-3-dev@pp3345.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you also add docs for this property in "DOC: standard connector
properties" in drm_connector.c?
