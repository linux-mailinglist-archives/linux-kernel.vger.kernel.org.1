Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B651EFFAB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 20:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgFESKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 14:10:22 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:34080 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgFESKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:10:22 -0400
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: /D7uevOGb7NUS3jLhu56Icbr/nUD7Qi81n2S5LiPeFIrT8ReeW9XNSW42OEZ0WFDiBKGdrKCfj
 uv8eVAIzuVxu4PI66k7fgrV13TriETEJNqX+6x2DtP6nVsDNEg85NlOCrAnDIfRbkobyP1HM3t
 6+XYZ8lfZTxgKh8idzSCtkPzVXNYBvTzGjMJO8aQWPzbeRQeNVkg1o+MjrMCdCuq2/nd1ecgGl
 IPiY58EJ5yOUn8NM0FPYRK+gsojASP025eDRmGjiDWLeKDzo/r+hETjg4zsiEMAAyzN9jnp5P9
 1Jg=
X-SBRS: 2.7
X-MesageID: 19701429
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.73,477,1583211600"; 
   d="scan'208";a="19701429"
Subject: Re: 5.7.0 / BUG: kernel NULL pointer dereference / setup_cpu_watcher
To:     Christian Kujau <lists@nerdbynature.de>,
        <linux-kernel@vger.kernel.org>
CC:     <xen-devel@lists.xenproject.org>, Juergen Gross <jgross@suse.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
References: <alpine.DEB.2.22.395.2006050059530.13291@trent.utfs.org>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <a467c2db-e72d-9a27-9fbd-9bcf8770de20@citrix.com>
Date:   Fri, 5 Jun 2020 19:10:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.395.2006050059530.13291@trent.utfs.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2020 09:36, Christian Kujau wrote:
> Hi,
>
> I'm running a small Xen PVH domain and upgrading from vanilla 5.6.0 to 
> <snip>
>
> Note: that "Xen Platform PCI: unrecognised magic value" on the top appears 
> in 5.6 kernels as well, but no ill effects so far.
>
> ---------------------------------------------------------------
> Xen Platform PCI: unrecognised magic value

PVH domains don't have the emulated platform device, so Linux will be
finding ~0 when it goes looking in config space.

The diagnostic should be skipped in that case, to avoid giving the false
impression that something is wrong.

~Andrew
