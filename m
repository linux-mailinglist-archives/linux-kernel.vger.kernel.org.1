Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EDF2B3DD9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgKPHmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:42:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbgKPHmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:42:10 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 680C1216C4;
        Mon, 16 Nov 2020 07:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605512530;
        bh=EMuMZSjkqH6ascelGPnz1mmTbJO93aIYo0vDYNY2YW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WiUacqv7ZpmYXBkUVqAw7+gvkPuqSL5X5M0J2EQ1IOmNQqgbIxXpnWiB8nP8MqwE/
         k/69GkXdI2eoKGJjIpz/o4TXZYFzmJ8OV5LrVYo/4l8yw84PTJUt9Z9bYefqzB8SEu
         yRsQDNliIGt4DXiMXWNnf9nLWn08aJoTKT7Uje5E=
Date:   Mon, 16 Nov 2020 13:12:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] phy: phy-brcm-sata: Allow configuration SATA AFE
 TX amplitude
Message-ID: <20201116074206.GN7499@vkoul-mobl>
References: <20201022205056.233879-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022205056.233879-1-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-20, 13:50, Florian Fainelli wrote:
> Hi Vinod, Kishon,
> 
> This patch series allows the configuration of the Broadcom SATA PHY TX
> amplitude which may be required in order to meet specific tests.

Applied, thanks

Btw please do convert the binding doc to yaml

Thanks
-- 
~Vinod
