Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C932F9E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390378AbhARLfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:35:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390326AbhARLfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:35:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 585A9222B3;
        Mon, 18 Jan 2021 11:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610969658;
        bh=eNPdKoFfpemoSd15yLf+Ww60XWG8xd8KX43TkTnRaHU=;
        h=Date:From:To:Cc:Subject:From;
        b=nAfAFieWT5mO/R9OQG/Lh5aF2Mmbz6KkclHnHsVKo+41C4rp7Tr/pHjlPNwAkQ99W
         9VeBocqWwPmtYK80HdLwRZT75B1RkuhLlhK853k5Fh4YVYpw0ThbcPQgujrtBbtFqe
         QRCzi6IDyQB9zeX07fVbhE+qd/1m/fK1+v5zGOBATfXQRBNfcn5b/iqJE5Fu+WelT+
         zFID2IxCie+wEyD9Be8/CytWbD75qrfjFa2JBp7D0zNmgm/mQxRZrpcwOIjoSv1aND
         y2abM80HSXpu2w37K96NRZdn54OWA0stasFPRrn7HyW0ppYEYcTYUk6OXMg9N5TBoN
         4bwG+e7fXm3+A==
Date:   Mon, 18 Jan 2021 13:34:11 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] ia64: fix build regression
Message-ID: <20210118113411.GM1106298@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2021-01-18

for you to fetch changes up to 32c2bc8f2d855d4415c9a05b727e34649397bfbe:

  ia64: fix build failure caused by memory model changes (2021-01-17 13:31:09 +0200)

----------------------------------------------------------------
ia64: fix build failure caused by memory model changes

----------------------------------------------------------------
Mike Rapoport (1):
      ia64: fix build failure caused by memory model changes

 arch/ia64/include/asm/sparsemem.h | 1 +
 1 file changed, 1 insertion(+)

-- 
Sincerely yours,
Mike.
