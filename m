Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8332D2DAB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgLHO6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:58:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729971AbgLHO6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:58:51 -0500
Date:   Tue, 8 Dec 2020 06:58:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607439490;
        bh=2DK5VJbB1dLxPU5eq82tpm0Zqe5mMOFjP1U3f6Jru40=;
        h=From:To:Cc:Subject:Reply-To:From;
        b=kf71kpUiFeZL6OJWEiBf/Ws8izbgwiovyXTtRpkPowtWc/LlGJqsHAZk3fsFL9VZb
         A9eM3y/pHEIxHNrLjLgMzwn8VOxy3YRAJWKz3dpgmTspj85npP4gAXkJtWhMNCFXXe
         NwwKq58BZe4WjDkqAyRtrnmCY7kQvZBMW3CZnpIh2UcNQ44poLNGnN/6Fv9p4xAUTi
         ttXKNqJFoQ/iFsKS11BRhvQpj++cSxwxfyLJCewDMdvbgehWVdU4Xp2vH3LlWKwPau
         oCZQxrhUVwqAjaZUuU1kwrP10jj+rUNzshTNYiXKXR3syNn+2CneEHkucKjUTfKJU1
         wi0u9tgb9v3lw==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     frederic@kernel.org
Cc:     boqun.feng@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: One potential issue with concurrent execution of RCU callbacks...
Message-ID: <20201208145810.GA4875@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Frederic,

Boqun just asked if RCU callbacks ran in BH-disabled context to avoid
concurrent execution of the same callback.  Of course, this raises the
question of whether a self-posting callback can have two instances of
itself running concurrently while a CPU is in the process of transitioning
between softirq and rcuo invocation of callbacks.

I believe that the answer is "no" because BH-disabled context is
an implicit RCU read-side critical section.  Therefore, the initial
invocation of the RCU callback must complete in order for a new grace
period to complete, and a new grace period must complete before the
second invocation of that same callback to start.

Does that make sense, or am I missing something?

							Thanx, Paul
