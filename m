Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B6B20E20D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 00:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390051AbgF2VCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 17:02:05 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:40671
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731035AbgF2VCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:02:00 -0400
X-IronPort-AV: E=Sophos;i="5.75,295,1589234400"; 
   d="scan'208";a="353082135"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 23:01:57 +0200
Date:   Mon, 29 Jun 2020 23:01:55 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Randy Dunlap <rdunlap@infradead.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] Documentation: Coccinelle: fix typos and command
 example
In-Reply-To: <725b57dd-cfde-a63f-0475-954452761508@infradead.org>
Message-ID: <alpine.DEB.2.22.394.2006292301200.2407@hadrien>
References: <725b57dd-cfde-a63f-0475-954452761508@infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  As Coccinelle features get added some more advanced SmPL patches
>  may require newer versions of Coccinelle. If an SmPL patch requires
> -at least a version of Coccinelle, this can be specified as follows,
> +at minimum version of Coccinelle, this can be specified as follows,

at -> a

thanks,
julia

>  as an example if requiring at least Coccinelle >= 1.0.5::
>
>  	// Requires: 1.0.5
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
