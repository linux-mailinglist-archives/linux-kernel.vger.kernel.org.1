Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886CC201BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 22:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388383AbgFSUAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 16:00:36 -0400
Received: from ms.lwn.net ([45.79.88.28]:55506 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388076AbgFSUAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:00:36 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id BE2272CD;
        Fri, 19 Jun 2020 20:00:35 +0000 (UTC)
Date:   Fri, 19 Jun 2020 14:00:34 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 01/22] docs: dt: convert booting-without-of.txt to ReST
 format
Message-ID: <20200619140034.5d9f368d@lwn.net>
In-Reply-To: <f03680f606053c8516cf7b1923fa067438b33d00.1592203650.git.mchehab+huawei@kernel.org>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
        <f03680f606053c8516cf7b1923fa067438b33d00.1592203650.git.mchehab+huawei@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 08:50:06 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> +Copyright |copy| 2005 Benjamin Herrenschmidt <benh at kernel.crashing.org>,
> +IBM Corp.
> +
> +Copyright |copy| 2005 Becky Bruce <becky.bruce at freescale.com>,
> +Freescale Semiconductor, FSL SOC and 32-bit additions
> +
> +Copyright |copy| 2006 MontaVista Software, Inc.
> +Flash chip node definition

So use of |copy| like this has caused complaints in the past; I think it's
probably better to leave these as they are.

Thanks,

jon
