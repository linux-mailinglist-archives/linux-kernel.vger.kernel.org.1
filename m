Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EDF1A6F69
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 00:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389727AbgDMWrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 18:47:46 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:41008 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgDMWm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 18:42:59 -0400
Date:   Mon, 13 Apr 2020 22:35:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1586817330;
        bh=jl/uF/D1PYwXMaOqDJFEWYGC7NJfXJLhzLgI8MtWbvw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=DLGTLJlDtp72qIxjJIcyWYZi04gJ8hiXW7N14NeSglVLHZmfXyH1F59RPbbU1vVO9
         IqtLf5AzSsJ/8rvh3QYEb20XgGZBMhQcOf/9KhfhymnOu7KNHXeftPdXopouqzN91O
         bQZEe2JuSnGJRjZnvu9mf5KtfXLai+ShnEtSLccM=
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
Subject: Re: [PATCH 5/5] drm/i915: Replace "Broadcast RGB" with "RGB quantization range" property
Message-ID: <daCvJk4O6rHOwEometGSPENJupb6adPr583_dLEetvftUQPbK4198VDijHGzM9uTm9bP3TEyGCZvxKe5PSvqWBg5xhXkL_7EiAQlmEPKWQI=@emersion.fr>
In-Reply-To: <20200413214024.46500-6-dev@pp3345.net>
References: <20200413214024.46500-1-dev@pp3345.net>
 <20200413214024.46500-6-dev@pp3345.net>
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

On Monday, April 13, 2020 11:40 PM, Yussuf Khalil <dev@pp3345.net> wrote:

> DRM now has a globally available "RGB quantization range" connector
> property. i915's "Broadcast RGB" that fulfils the same purpose is now
> considered deprecated, so drop it in favor of the DRM property.

For a UAPI point-of-view, I'm not sure this is fine. Some user-space
might depend on this property, dropping it would break such user-space.

Can we make this property deprecated but still keep it for backwards
compatibility?
