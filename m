Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA3E260F99
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 12:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgIHKZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 06:25:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbgIHKZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:25:52 -0400
Received: from localhost (unknown [122.182.239.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E6B20672;
        Tue,  8 Sep 2020 10:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599560752;
        bh=wWnN8wIGdEYRQeyZKiDo3zvwQLQ/nImIw3EzYlJq4Rc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W75xSdOthz2YfDEqQ6Y6fTbdMUTwjPxK0P2ioDuwOlLUrb69hyZtEjVEJe5FlKoYZ
         iBHcF6xvQUmBzXQfFQ6ZQXidFYF0sZBO7q3nOJnCILx3TK8iROksvMSgiVcCpUVVap
         qBO2ld5YB33YTuIOcp8OqGeAXBCmZVybvxHk6bZA=
Date:   Tue, 8 Sep 2020 15:55:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     kishon@ti.com, nsekhar@ti.com, vigneshr@ti.com,
        jan.kiszka@siemens.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5] dt-binding: phy: convert ti,omap-usb2 to YAML
Message-ID: <20200908102548.GD77521@vkoul-mobl>
References: <20200831142130.21836-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831142130.21836-1-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-08-20, 17:21, Roger Quadros wrote:
> Move ti,omap-usb2 to its own YAML schema.

Applied, thanks

-- 
~Vinod
