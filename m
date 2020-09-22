Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E729327384B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 04:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbgIVCCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 22:02:01 -0400
Received: from shelob.surriel.com ([96.67.55.147]:45630 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbgIVCCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 22:02:01 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1kKXcv-0003Cm-C8; Mon, 21 Sep 2020 22:01:53 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, kernel-team@fb.com, niketa@fb.com,
        akpm@linux-foundation.org, sjenning@redhat.com, ddstreet@ieee.org,
        konrad.wilk@oracle.com, hannes@cmpxchg.org
Subject: [PATCH 0/2] mm,swap: skip swap readahead for instant IO (like zswap)
Date:   Mon, 21 Sep 2020 22:01:46 -0400
Message-Id: <20200922020148.3261797-1-riel@surriel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: riel@shelob.surriel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both with frontswap/zswap, and with some extremely fast IO devices,
swap IO will be done before the "asynchronous" swap_readpage() call
has returned.

In that case, doing swap readahead only wastes memory, increases
latency, and increases the chances of needing to evict something more
useful from memory. In that case, just skip swap readahead.


