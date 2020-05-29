Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B27C1E8640
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 20:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgE2SHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 14:07:47 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:45358 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgE2SHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:07:46 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2B60F1C0385; Fri, 29 May 2020 20:07:45 +0200 (CEST)
Date:   Fri, 29 May 2020 20:07:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, kernel@puri.sm, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mchehab@kernel.org, Anson.Huang@nxp.com,
        agx@sigxcpu.org, angus@akkea.ca, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: dts: Add a device tree for the Librem5 phone
Message-ID: <20200529180743.GA1081@bug>
References: <20200514155737.12160-1-martin.kepplinger@puri.sm>
 <20200529162850.GC3709@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529162850.GC3709@amd>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Plus, do we need calibration matrix for magnetometer?

Best regards,
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
