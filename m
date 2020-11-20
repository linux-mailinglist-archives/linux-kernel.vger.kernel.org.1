Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95252BA604
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgKTJYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:24:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39242 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgKTJY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:24:29 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605864268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nKeWeXqWF+qPl0zbIG9umt42PI6XyksUGhAAg3m7/dI=;
        b=T9h+DEjk8Q1Z0jfp916FViN6zn+8vFtp7h0cK9FcLyCEsnKcJWhYhxH81MqAvv6HJPeJ2i
        T/fHORVFq/cHIsGfZ131h2uVDogTrFxGpop2sxd1p0VIc2fEmFmER9rYlZCU1LR4cMOvuo
        2pqPp7A4wFCxBa2RKpkRD6V7pPe8T/vXI8ERo08MVu8GyFyytmzTPq0dtyiobsiZESDQnO
        rIzUu6sNEVk2Wg5/dA4q57HoFGMbyimB2tiVAwtJxhFvFkJNjG99OOUc/0TrDM0YwHgTHF
        /5CGD8Jh+EUwWxxcVFI5OVPWWHOaO8cssvjIk8iVIX+aJ/mv9EzpPcu+pCGLNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605864268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nKeWeXqWF+qPl0zbIG9umt42PI6XyksUGhAAg3m7/dI=;
        b=KYtyxa1lVuyBrSNe/1X9lBEy3bljdPNlFi9VaTafX250MAPGJQV1ARAktW2toa5ZIaETnx
        HOccsG1YisDg6iCQ==
To:     linux-ide@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>, tglx@linutronix.de
Subject: [PATCH v2 0/2] ide: Remove in_interrupt().
Date:   Fri, 20 Nov 2020 10:24:19 +0100
Message-Id: <20201120092421.1023428-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the discussion about preempt count consistency across kernel
configurations:

 https://lore.kernel.org/r/20200914204209.256266093@linutronix.de/

it was concluded that the usage of in_interrupt() and related context
checks should be removed from non-core code.

This ide subsystem has two in_interrupts() checks before mutex/wait-event
invocations.

Changes since v1=20=20=20=20=20=20
  https://lkml.kernel.org/r/20201113161021.2217361-1-bigeasy@linutronix.de
  - added acks
  - added lkml to Cc:

Sebastian

