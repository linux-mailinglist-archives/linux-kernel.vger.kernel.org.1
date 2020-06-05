Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A421F1F02D7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 00:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbgFEWV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 18:21:58 -0400
Received: from trent.utfs.org ([94.185.90.103]:45822 "EHLO trent.utfs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgFEWV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 18:21:58 -0400
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 2E6B95FCDB;
        Sat,  6 Jun 2020 00:21:56 +0200 (CEST)
Date:   Fri, 5 Jun 2020 15:21:56 -0700 (PDT)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Juergen Gross <jgross@suse.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Subject: Re: 5.7.0 / BUG: kernel NULL pointer dereference /
 setup_cpu_watcher
In-Reply-To: <a467c2db-e72d-9a27-9fbd-9bcf8770de20@citrix.com>
Message-ID: <alpine.DEB.2.22.395.2006051519430.13291@trent.utfs.org>
References: <alpine.DEB.2.22.395.2006050059530.13291@trent.utfs.org> <a467c2db-e72d-9a27-9fbd-9bcf8770de20@citrix.com>
User-Agent: Alpine 2.22 (DEB 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jun 2020, Andrew Cooper wrote:
> PVH domains don't have the emulated platform device, so Linux will be
> finding ~0 when it goes looking in config space.
> 
> The diagnostic should be skipped in that case, to avoid giving the false
> impression that something is wrong.

Understood, thanks for explaining that. I won't be able to edit 
arch/x86/xen/platform-pci-unplug.c to fix that though :-\

Christian.
-- 
BOFH excuse #134:

because of network lag due to too many people playing deathmatch
