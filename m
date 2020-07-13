Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9B521CB72
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 23:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgGLVC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 17:02:29 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59228 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbgGLVC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 17:02:29 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 97C8D1C0BDE; Sun, 12 Jul 2020 23:02:23 +0200 (CEST)
Date:   Sun, 12 Jul 2020 23:02:22 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Ondrej Jirman <megous@megous.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Luca Weiss <luca@z3ntu.xyz>,
        Tomas Novotny <tomas@novotny.cz>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] ARM: dts: sun8i-a83t-tbs-a711: Add support for
 the vibrator motor
Message-ID: <20200712210222.GA983@bug>
References: <20200702112041.1942707-1-megous@megous.com>
 <20200702112041.1942707-4-megous@megous.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702112041.1942707-4-megous@megous.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The board has a vibrator mottor. Hook it to the input subsystem.

motor, I believe.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
