Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC0529E8CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgJ2KQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJ2KQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:16:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF54C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=oDJgefKs9xoc4uZr+/1eK6hrCKP+Vr9doGZVzreNMJQ=; b=etZnIfsbPOgHfGNEo+WrBNGg68
        psjP8u9zcw9rY93vQrENi8S9JJWh78rQwpB/1s67UrtzF3D1mzqU67tjBGqCXgITiHmzEzjvg/XTm
        xanT4BVibDehZMYHReOnVQwq+5Jfc5vj+Gl8Xk649dMRLl/zTWK1ObGjxOgKE0E4UB/QWyLvxlOxj
        9j1MojuGs4Hw/VAfeQ7OT28ty65X1kRSFX15YfQYY2VAw+ZsEy0gldW/7kwmEfiVSOiz3E7vmz8sv
        zOsd8qkez+eKsy8IDwRhqHsgB2nbHgAno0OQtIf8s8HCAK0UI+dGhu2siVirEy5HQ/gT3OWqk1cvq
        EnOa7oog==;
Received: from 089144193201.atnat0002.highway.a1.net ([89.144.193.201] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kY4z4-000453-OP; Thu, 29 Oct 2020 10:16:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: simplify follow_pte a bit
Date:   Thu, 29 Oct 2020 11:14:30 +0100
Message-Id: <20201029101432.47011-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

this small series drops the not needed follow_pte_pmd exports, and
simplifies the follow_pte family of functions a bit.
