Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9EF2FF455
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbhAUT0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:26:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:41468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbhAUT0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:26:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B26E23136;
        Thu, 21 Jan 2021 19:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611257118;
        bh=4nmLhxegZ4isBOf/ylK1chI6uve+Ot3OXnReI6II4a4=;
        h=Date:From:To:Cc:Subject:From;
        b=FRRfX0nT0diFsi+y5mknUxXqeLqyvfUnUydsm7wU1mnV4WV8pDhpP6vRrJh5Kpr1i
         daRPKXRPlM3SC1AWPv3MLBz8Jmd/p9aptksT8JqbSa0zPSkBWTpqCCKRy22v94JrG2
         kuNlu6wlg47lcjxkoWMxijMVzUbzTeARVwI+Dx6GuBADl+yfH6LGCdJ4CX7WjoSfRB
         L1jkfkMhaSgoQZTORlRNLJ+EFp+XpfQbdAkd5CYTyX8G1OC+ltVwYHK8YYglr/FEyz
         fvp+D/iIi2QoQ/WXbQjLpSwGT93xa4rfAMlwI/5eSS6P59fW4YGfuJHbMxADLoMA4C
         j/YzXIKZqXL/A==
Date:   Thu, 21 Jan 2021 21:25:14 +0200
From:   Oded Gabbay <ogabbay@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.11-rc5
Message-ID: <20210121192514.GA5598@CORE.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

This pull request contains three important bug fixes for 5.11-rc5.
One of the fixes prevent a possible host machine crash, another
one prevents random card reset and the third adds a missing
backward compatibility to a uapi. More details are in the tag.

Thanks,
Oded

The following changes since commit cb5c681ab9037e25fcca20689c82cf034566d610:

  intel_th: pci: Add Alder Lake-P support (2021-01-21 18:54:43 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/linux.git tags/misc-habanalabs-fixes-2021-01-21

for you to fetch changes up to 2dc4a6d79168e7e426e8ddf8e7219c9ffd13b2b1:

  habanalabs: disable FW events on device removal (2021-01-21 20:30:22 +0200)

----------------------------------------------------------------
This tag contains the following bug fixes for 5.11-rc5/6:

- Clear the fence field in the PCI counters packet before sending
  the packet to the F/W. Not clearing it might cause the driver
  and F/W to get out-of-sync

- Fix backward compatibility in the uapi of IDLE check that is
  part of the INFO IOCTL.

- Tell the F/W to not access the Host (device outbound) while
  the driver removes the device. If that happens, the server
  might crash.

----------------------------------------------------------------
Oded Gabbay (2):
      habanalabs: fix backward compatibility of idle check
      habanalabs: disable FW events on device removal

Ofir Bitton (1):
      habanalabs: zero pci counters packet before submit to FW

 drivers/misc/habanalabs/common/device.c           | 9 +++++++++
 drivers/misc/habanalabs/common/firmware_if.c      | 5 +++++
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 2 ++
 3 files changed, 16 insertions(+)
