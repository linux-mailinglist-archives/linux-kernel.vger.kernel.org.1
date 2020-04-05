Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5628919EE2F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 23:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgDEVFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 17:05:38 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:53780 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbgDEVFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 17:05:37 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 14AAB40491;
        Sun,  5 Apr 2020 23:05:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1586120735; x=1587935136; bh=SM/5KLvsEB4XnzJNKN/
        86syCNnYK3ZcI6ZkskL3v1c0=; b=hirl5cMK07udssPSAT4IS46ygP52oiWF+Jl
        XRItTauqJl6I0/rXxS/5vA+uHIa/WJswKL6UL6TNdudhc4CaiefXDbHi1NAWehnL
        VUIkLCXX2yx9feN4kWmdXNpLZLFPCKPb7Kr/G32uK8I5bjxFoIpLcEILYEh6mNIE
        9ZXWbZK/mIBuTstZE9efR2Jthl6sjOPkoY7ZRetSMs9Menj+W3rcRzX+eGl4CnvA
        bvoSaK1wT1/5tBQ0M/Vfo8DVC9ALyavGE7+5gqvQHcIBxGIQXhkSbHR6RA7b/Z6+
        HtdpPmq+TKqTfTxLQN206PhjKecQZvaAb5wVE+6Xb6WlCL3pAmwEWL4TLWJgl2Rz
        MbQg7WEqWgo1iXDEKezEGCFzpvp+yYJ9es/84vupEKQ5EtT60RyFb7LX3aYxN/Tu
        a6qI99YFXmpP2tuIhyB1KTDwvNbJhRmGpvnVZHRD0uLLkmcOOOPILLeEar6vB6e+
        CF2G8eO6oTrfF/aG4qbK4Kp13soGl/Hu492aZn90LyCP8aShctLeUXkTFqIMhBWE
        D6WHNhbLNJFAwsgr6+CVf2O5jLFxBoT6WCJH63anE8jcPL8/IPXprf8AxYicfuxG
        hwKTrAJ78brwAKI7SeyVLN7jXlu8N4zml+DjVEZreNAMIrl4narjYrv2SbYjWwPI
        dHf2UdFE=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: -1.899
X-Spam-Level: 
X-Spam-Status: No, score=-1.899 tagged_above=-10 required=5
        tests=[BAYES_00=-1.9, URIBL_BLOCKED=0.001]
        autolearn=ham autolearn_force=no
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CK48F7kjvKda; Sun,  5 Apr 2020 23:05:35 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 6FA74403F1;
        Sun,  5 Apr 2020 23:05:35 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 08C03BAF;
        Sun,  5 Apr 2020 23:05:35 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Federico Vaga <federico.vaga@vaga.pv.it>
Subject: [PATCH] doc:locking: add hyperlinks to rt-mutex document
Date:   Sun,  5 Apr 2020 23:05:31 +0200
Message-Id: <20200405210531.24902-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch add missing hyperlinks to the rt-mutex document

Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
---
 Documentation/locking/rt-mutex-design.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/locking/rt-mutex-design.rst b/Documentation/locking/rt-mutex-design.rst
index bdd6b0013e02..15dc8db8b804 100644
--- a/Documentation/locking/rt-mutex-design.rst
+++ b/Documentation/locking/rt-mutex-design.rst
@@ -9,7 +9,7 @@ Licensed under the GNU Free Documentation License, Version 1.2
 
 This document tries to describe the design of the rtmutex.c implementation.
 It doesn't describe the reasons why rtmutex.c exists. For that please see
-Documentation/locking/rt-mutex.rst.  Although this document does explain problems
+:doc:`./rt-mutex`.  Although this document does explain problems
 that happen without this code, but that is in the concept to understand
 what the code actually is doing.
 
@@ -308,7 +308,7 @@ not true, the rtmutex.c code will be broken!), this allows for the least
 significant bit to be used as a flag.  Bit 0 is used as the "Has Waiters"
 flag. It's set whenever there are waiters on a mutex.
 
-See Documentation/locking/rt-mutex.rst for further details.
+See :doc:`./rt-mutex` for further details.
 
 cmpxchg Tricks
 --------------
-- 
2.25.1

