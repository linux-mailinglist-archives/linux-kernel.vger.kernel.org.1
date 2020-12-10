Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6390E2D5EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbgLJPC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:02:59 -0500
Received: from ms.lwn.net ([45.79.88.28]:35604 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391678AbgLJOt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:49:27 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1CD882DC;
        Thu, 10 Dec 2020 14:48:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1CD882DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1607611726; bh=sC0Gf4Xe3WsWr5Sn8762hoEqMXZBZPx8IRseLLdaRe4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eGD8bPi3IZvW78p9sLQ/CMQfPnevkvjLq7lYzPj+vyFMORZvDyyHZ9s36nIct9qQ2
         B2N1zDNil8y/Ubw4Yx0P1l3Ks7osVAqYoERF60MSzPgUcyZ0HAcnjrHiu9dBixVJXP
         KrNj40SDABGRMk0ITi1sbQHz4LdjowhcQmpWQ8M5a6ectgriy9/LvWiUwwpgdnecSV
         ncIz50MhXMzHALLSJFULC/AQTf32tv1hfsqp45HfaoS+LDXOfEQqgI/tW7y4KsGIa/
         DvFMw9fpKiU7SQKYsPMVNurzqnsXFfzMWuHQZaRacR8uqiffU974G6P2RYmNdTI08S
         IixhD3V9a0h6A==
Date:   Thu, 10 Dec 2020 07:48:45 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] docs: conf.py: fix sphinx version detection for
 margin set
Message-ID: <20201210074845.4eb67f22@lwn.net>
In-Reply-To: <0e610cbb57e85864b23d2b8fffa65c6b137daaac.1607597287.git.mchehab+huawei@kernel.org>
References: <cover.1607597287.git.mchehab+huawei@kernel.org>
        <0e610cbb57e85864b23d2b8fffa65c6b137daaac.1607597287.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 11:55:40 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> The PDF generator has a logic to detect the proper way to
> setup the page margins. By default, the page has about
> 14.8 cm, which is too short to display some tables and literal
> blocks. So, previous patches changed it to be around 17.5 cm,
> but the logic only works with Sphinx version 1.x.x.
> 
> Fix it.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Jonathan Corbet <corbet@lwn.net>

Feel free to route this one with the rest of the set.

Someday it might be nice to isolate all of the latex stuff into
conf-latex.py or some such so most of us don't have to look at it..:)

Thanks,

jon
