Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8861A7F95
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 16:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389959AbgDNOXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 10:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389948AbgDNOXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:23:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9462FC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=jH6UnH49S0cp9VjjGH+ilK/cv0LJ/UCyQV7CKBgYn80=; b=TKDMioLd0KsJV2DV87JMvTrN2T
        AhDS+bAIgrB6KG+Vfmv4JtfyUhpgvUFQOvGV69buiRVzd9/Pj6Ro0Qy79G/yICVpHW4L/JfRkA5U7
        KESJHCk9i+R4zWgRenZGUS2UNW2U+WuD5DrISfdj/uYZzryzc9O9oirbRKvxAOuJqMsdgdJUiZBXP
        Y5AdkIqCSf2w3/w5H2K+ggd8jU9Ra739uLJjFnqHAkRLCTL8AD4KaqsW7FK7XMWnMMhULPkRVSmk/
        tx8WZGu37su/so71SAS/ibkNf5znZ/uGq9PQGxlobxxqi55rUXDs9y9Zo59fRQ4t7AfoFvgDWonsL
        qm7k89ow==;
Received: from [2001:4bb8:180:384b:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOMSw-000214-G3; Tue, 14 Apr 2020 14:23:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: stop messing with set_fs in arm_sdei
Date:   Tue, 14 Apr 2020 16:23:00 +0200
Message-Id: <20200414142302.448447-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

can you take a look at this series?  I've been trying to figure out
what the set_fs in arm_sdei is good for, and could not find any
good reason.  But I don't have any hardware implementing this interface,
so the changes are entirely untested.
