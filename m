Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC18219077
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 21:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgGHT3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 15:29:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53204 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHT3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:29:54 -0400
Message-Id: <20200708192804.911958542@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594236593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=09cNi+ya/8B7RJmmC0E8V+/roSs8mduHpnGmmws4aaE=;
        b=qusWOtvobklnRP1ntJFsERlbaM4LWnsRbWqkvAHTduQVfH/+AL44CDJjK7veiJy50JnJRH
        d9QXuGF2J7vU4P/Vpm/xI5Viv5vr2yIJtrNIWmZ7ff+JEPaaAJvk27lcOFIjEatfxsvmRu
        oe4GguQWWESsjJKIB98HSyz+SDTJHe00h/V6/7NVXJEumLws1pQ+PcjytTxQCHSJtX+f4m
        cPL1l90henvXCE7lgKYYabxRYMbZiCYsmcth6T+lC0kSDdVFTfrISW5L3ndEhrO8wXZ/OR
        suvz94cIimZatM748DUK+LvMeY+KLAk0rxAZda74yxwn7Pu4HpoHnmFWLFgOmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594236593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-transfer-encoding:content-transfer-encoding;
        bh=09cNi+ya/8B7RJmmC0E8V+/roSs8mduHpnGmmws4aaE=;
        b=hQNrVnCTfVG5GEAplyg0jtJvcAs5dzLuLCeubFk5dCDBIBGvzrlXO/gBfJnuS6xEDn+hqA
        1aRDraQ942VPGuCg==
Date:   Wed, 08 Jul 2020 21:28:04 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org
Subject: [patch 0/3] x86/entry: A couple of small fixes
Content-transfer-encoding: 8-bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - Syzbot reported a missing local_irq_disable() in exc_alignment_check()
 - A missing noinstr annotation
 - Make a function static which is not longer used from ASM code

Thanks,

	tglx

