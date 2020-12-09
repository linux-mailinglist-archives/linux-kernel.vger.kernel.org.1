Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F122D4C91
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 22:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbgLIVNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 16:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgLIVNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 16:13:51 -0500
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B923BC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 13:13:10 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id D768DB42;
        Wed,  9 Dec 2020 22:13:08 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id x9zYbiQswOq1; Wed,  9 Dec 2020 22:13:08 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 57437ABE;
        Wed,  9 Dec 2020 22:13:08 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kn6ln-006kOC-Jz; Wed, 09 Dec 2020 22:13:07 +0100
Message-Id: <20201209205829.693745475@ens-lyon.org>
User-Agent: quilt/0.65
Date:   Wed, 09 Dec 2020 21:58:29 +0100
From:   samuel.thibault@ens-lyon.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: [patch 0/3] speakup: simplify relation between line disc and synth
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series reworks the relation between the speakup line discipline and the
speakup synthesizers. This is probably fixing a few minor issues, but since it
is invasive it'll better wait for 5.11.

