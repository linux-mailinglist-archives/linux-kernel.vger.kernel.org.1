Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D3628E5E9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgJNSEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:04:50 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:23940 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgJNSEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1602698691;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=QP9dZ/kf6WxmC+XFLjXj3iwd2bvWj8WJ3e4EPYelksU=;
  b=XYM/rqaF0FOUMix2FVuHFpG2TNZLge9C2lwZsIMvq0LSD3flDf0ASZ5U
   RuLPJ5Yk9JIDyxwxRZGoMwZwJTBlC1J3Nnn0QXcIXElTLbuZJD0Ohqg5J
   bMPjp9BhMUVpQm7UcHVYGwsCJvFRhc35o1/aqcbYz8ityVV4hX7I0a/ro
   M=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: RkRU6LoFb+K0uroA17V3eGSGvjuUUGMUujSWCqKRxmtq2qsv7vOw8BkkHt9zfs7MM0a9cL4/Ft
 2dUiIVTILpDeiiulU9gHbgx2gjg8+21xfs5GSiPybMgsipLEe8gUsLsaJNrwhMSLLMQsemLMrK
 wdiahS+UH2PIC8/GMR79mm8Bs/hMc8XQYiz5aXGXmdH8ykSz0VWu7I/DAiuKR6KfhXRT9DtM9v
 zbRh/CILhefBnCwff+hwhCnTEGRqgmAYgX+34s8k22jyocg6vnUZJwOQKaxQIPzmtyJ671KRly
 GoE=
X-SBRS: 2.5
X-MesageID: 28991967
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,375,1596513600"; 
   d="scan'208";a="28991967"
Subject: Re: [SUSPECTED SPAM][PATCH 0/2] Remove Xen PVH dependency on PCI
To:     Jason Andryuk <jandryuk@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        <xen-devel@lists.xenproject.org>
CC:     "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
References: <20201014175342.152712-1-jandryuk@gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <4973553f-fad2-83b9-fa19-26370ced2c2d@citrix.com>
Date:   Wed, 14 Oct 2020 19:04:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201014175342.152712-1-jandryuk@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 FTLPEX02CL05.citrite.net (10.13.108.178)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2020 18:53, Jason Andryuk wrote:
> A Xen PVH domain doesn't have a PCI bus or devices,

[*] Yet.

> so it doesn't need PCI support built in.

Untangling the dependences is a good thing, but eventually we plan to
put an optional PCI bus back in, e.g. for SRIOV usecases.

~Andrew
