Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5302E21E478
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 02:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGNAZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 20:25:21 -0400
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:45028 "EHLO
        ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgGNAZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 20:25:20 -0400
X-Greylist: delayed 1262 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jul 2020 20:25:20 EDT
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from grey.csi.cam.ac.uk ([131.111.57.57]:54032)
        by ppsw-32.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.136]:25)
        with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        id 1jv8Qj-000QEA-1e (Exim 4.92.3)
        (return-path <dot@dotat.at>); Tue, 14 Jul 2020 01:04:17 +0100
Date:   Tue, 14 Jul 2020 01:04:17 +0100
From:   Tony Finch <dot@dotat.at>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unifdef: Replace HTTP links with HTTPS ones
In-Reply-To: <20200713202755.38022-1-grandmaster@al2klimov.de>
Message-ID: <alpine.DEB.2.20.2007140101011.32181@grey.csi.cam.ac.uk>
References: <20200713202755.38022-1-grandmaster@al2klimov.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander A. Klimov <grandmaster@al2klimov.de> wrote:

> -    "@(#) $URL: http://dotat.at/prog/unifdef $\n"
> +    "@(#) $URL: https://dotat.at/prog/unifdef $\n"

Yes, thank you! Feel free to add my:

Acked-by: Tony Finch <dot@dotat.at>

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  https://dotat.at/
Selsey Bill to Lyme Regis: West veering northwest 4 or 5, becoming variable 3
at times. Smooth or slight, occasionally moderate offshore. Occasional rain at
first. Good, occasionally moderate at first.
