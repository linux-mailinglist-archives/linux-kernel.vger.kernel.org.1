Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0292A5F08
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgKDIAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:00:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKDIAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:00:35 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84BA022384
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604476834;
        bh=uakIj9UlpwM4ruA9Bh4DX6cGZRU2rLSSNCIfsqSO5tY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PXdoyWKUarnodgVoyXFD0SjLhZFDwqiYvCUfOmF+V2zLSFJ+kx4QW3j4bSxXBB66c
         gm+2tkumCRDNiThWNNirCE7y+bexPdYbUSrk7mlPjwMhYN8zgEU6DTgzt9GUe1hnEK
         x23C/z0zWE8K+F8ptKCh4iFTtPAnXomGkKUW/Z58=
Received: by mail-ej1-f54.google.com with SMTP id o9so26358737ejg.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 00:00:34 -0800 (PST)
X-Gm-Message-State: AOAM532LHTDVt14s9+dk7TzGYZzxv8NLuymOebNiiiRyjiNgTHv4wLlD
        8SfTMiUyTIq+LqqIHPYSsmtqSOiX/V7JOj1sKlM=
X-Google-Smtp-Source: ABdhPJwly3tnKcpcwqjSjAw6YJSJww75G81BXVlU16Eiz0t2Mw8ntBqqZIpOrQArxM7bp5+Xvu1N1A7tDjuUGq6YAwU=
X-Received: by 2002:a17:906:5247:: with SMTP id y7mr23329917ejm.503.1604476833015;
 Wed, 04 Nov 2020 00:00:33 -0800 (PST)
MIME-Version: 1.0
References: <20201104030959.13264-1-alice.guo@nxp.com> <20201104030959.13264-2-alice.guo@nxp.com>
In-Reply-To: <20201104030959.13264-2-alice.guo@nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 4 Nov 2020 09:00:20 +0100
X-Gmail-Original-Message-ID: <CAJKOXPfOZqm-4_4-k78tTWoQpch4gm7BWDxjzEQhPF5bTTfiVQ@mail.gmail.com>
Message-ID: <CAJKOXPfOZqm-4_4-k78tTWoQpch4gm7BWDxjzEQhPF5bTTfiVQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
To:     Alice Guo <alice.guo@nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, peng.fan@nxp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 at 04:12, Alice Guo <alice.guo@nxp.com> wrote:
>
> Add DT Binding doc for the Unique ID of i.MX 8M series.

You sent twice patches labeled v1. Which one is v1 and which is v2?
Which should be reviewed? What are the differences?

Best regards,
Krzysztof
