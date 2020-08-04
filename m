Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889E623B279
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 03:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgHDBtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 21:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgHDBtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 21:49:10 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98108C06174A;
        Mon,  3 Aug 2020 18:49:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5C318127931A0;
        Mon,  3 Aug 2020 18:32:24 -0700 (PDT)
Date:   Mon, 03 Aug 2020 18:49:09 -0700 (PDT)
Message-Id: <20200803.184909.1734178815773797142.davem@davemloft.net>
To:     vaibhavgupta40@gmail.com
Cc:     helgaas@kernel.org, bhelgaas@google.com, bjorn@helgaas.com,
        vaibhav.varodek@gmail.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH v3 0/3] drivers: ide: use generic power management
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200713173613.2095-1-vaibhavgupta40@gmail.com>
References: <20200713173613.2095-1-vaibhavgupta40@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Aug 2020 18:32:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Date: Mon, 13 Jul 2020 23:06:10 +0530

> Linux Kernel Mentee: Remove Legacy Power Management.
> 
> The purpose of this patch series is to remove legacy power management callbacks
> from ide drivers.
> 
> The suspend() and resume() callbacks operations are still invoking
> pci_save/restore_state(), pci_set_power_state(), pci_enable/disable_state(),
> etc. and handling the power management themselves, which is not recommended.
> 
> The conversion requires the removal of the those function calls and change the
> callback definition accordingly and make use of dev_pm_ops structure.

Series applied.
