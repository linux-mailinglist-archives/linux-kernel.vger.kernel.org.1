Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E862D6818
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 21:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404541AbgLJUD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 15:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404502AbgLJUDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 15:03:48 -0500
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B082C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 12:03:08 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 24279D18;
        Thu, 10 Dec 2020 21:03:07 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id whk9VzjqCmXX; Thu, 10 Dec 2020 21:03:06 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (lfbn-bor-1-56-204.w90-50.abo.wanadoo.fr [90.50.148.204])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 8088AA25;
        Thu, 10 Dec 2020 21:03:06 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1knS9Z-00AfPJ-Pf; Thu, 10 Dec 2020 21:03:05 +0100
Message-Id: <20201210200123.451204785@ens-lyon.org>
User-Agent: quilt/0.65
Date:   Thu, 10 Dec 2020 21:01:23 +0100
From:   samuel.thibault@ens-lyon.org
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [patch 0/3] speakup: simplify relation between line disc and synth
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series reworks the relation between the speakup line discipline and the
speakup synthesizers. This is probably fixing a few minor issues, but since it
is invasive it'll better wait for 5.11.

