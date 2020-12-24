Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE17B2E261D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgLXLOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgLXLOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:14:18 -0500
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CDFC061794
        for <linux-kernel@vger.kernel.org>; Thu, 24 Dec 2020 03:13:37 -0800 (PST)
Received: from localhost (home.natalenko.name [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id D7AD18F90CF;
        Thu, 24 Dec 2020 12:13:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1608808408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=gU2GHX8ErPj4WjP6+ZyvbnUEfSR5V0an6n9r08YKmTI=;
        b=GlVlOf7zNLC6z0NZkpy/jvc683cBEzTUPITSuQnHFVZjRiKmij5x9Fb9umr/+NzCNXr1+v
        yCc4XHFduiZ9/q78BvpYfatQ0xS2og6pff9RIAl6PUpFMzrG5qBRejqi0h6PwZ8aGLKQem
        2t2pKl00Ab9liNtso+RIxzTymTZLWmc=
Date:   Thu, 24 Dec 2020 12:13:27 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     Mandeep Singh Baines <mandeep.baines@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: min_filelist_kbytes vs file_is_tiny
Message-ID: <20201224111327.knhqdz3hloxfcksv@spock.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Mandeep, Guenter et al.

I came across the out-of-tree patch [1] that apparently is still alive
after 10 years of residing in the Chromium OS tree, and I have a couple
of questions if you don't mind spending your time answering them.

1. is this knob really necessary given there's an explicit bailout
mechanism relying on `file_is_tiny` which depends on the sum of high
watermarks across the zones? Wouldn't increasing `vm.min_free_kbytes`
achieve basically the same?

2. if `vm.min_free_kbytes` is not an option, would setting
`file_is_tiny` based on your `min_filelist_kbytes` knob achieve the
same?

3. if not, is `memory.min` cgroup2 knob supposed to work in a similar
manner? it looks to be unavailable for the root cgroup, though.

What I'm looking for, basically, is to achieve the effect of the
mentioned patch using mechanisms that are already available in the
upstream kernel.

Thank you.

[1] https://chromium.googlesource.com/chromiumos/third_party/kernel-next/+/545e2917dbd863760a51379de8c26631e667c563^!/

-- 
  Oleksandr Natalenko (post-factum)
