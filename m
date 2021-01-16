Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24B42F8AED
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 04:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbhAPDEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 22:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbhAPDET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 22:04:19 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE342C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 19:03:38 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id h205so16083665lfd.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 19:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=YynDobxZUwWYHcYY8erKto+2kYcG/wSTDExyGtejXbQ=;
        b=cZBbMoscxO1Fh2cD9EwfnVEYNPteThkgdx41hnuEg34rfRmeYwl+iy99rzBv+qF7Hl
         5kla/Sn5aZzkytwLZm0iyBiBZmMV19oJr9WxF6yhLwND9cB6L/wAHL5FF1IvxgD4xH66
         gp/BPp1kffPTDWdBmx5fj810/DW5ejjrpxyI+nyxejYxvQxSlMjUMX/dBj8sws1bsaee
         xE8udARGmRu9k6OsvuovzADw8If3YCwlHoKXPN23lgZCa/oyEYHSNEjF9i9xAk9LlP29
         8hBvB1v+kH2Wa8j7QhB7ka2I4QnsHcoY0f7UrrjN89CylpmaDOUE8VYJRKMH/a7qZau4
         b3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YynDobxZUwWYHcYY8erKto+2kYcG/wSTDExyGtejXbQ=;
        b=R4v4e47cLUqTkxo55gego+PRMpGxjiKEyAlMBa4UDp1/UgWoBS3Ts6OuCdQM/qeBHE
         xGbWPTvxy87JpFta96xhnaiEVZ8UjtAqnHeG13dNSTMoP13cxzmPFwellYUlC7R0oP45
         lHt95QuA2higXCWJvG5g61y1Hn+kXTdb0dzCYeGvJ9FzavoHavpinCwFU0eo8HVNEazR
         W5QJ63uEsLOl5Ei2vczvwpvDTDiGEXl/p9Iqf1lwFFS/+k1Q+MdlnmGtVSqgNHzpk2ST
         Y9pgKbWJtRys+T3pFxZ1w4RN2q+jyKtj0kCVOSsj4Co+06UWsWaQrfgaWIYZQcsvZElB
         CB8A==
X-Gm-Message-State: AOAM53171MF7cMLZSFvjtTGMi4V7tf5TlF1GnFGvmtjAgg2LPuMTw4lF
        /dgEOFBfNvXSqE9Sz+7nt2dE2cjfkb7qhAaNXzfC7lc1K5vESG6D
X-Google-Smtp-Source: ABdhPJwNNt+vm0/iMJb3pwrNJ7dmkq18DNxrSqdtyt7SLn/IiHwVbeSjSBHySTAboJgd90QbeLioZ2BGOZisQVuXAJc=
X-Received: by 2002:ac2:5612:: with SMTP id v18mr7096589lfd.584.1610766216717;
 Fri, 15 Jan 2021 19:03:36 -0800 (PST)
MIME-Version: 1.0
From:   Michael Katzmann <vk2bea@gmail.com>
Date:   Fri, 15 Jan 2021 22:03:25 -0500
Message-ID: <CAMyt5OTrOuqoiEsWn2c7pMquZayVExgNKqzDt_XrqK6pLQ=32Q@mail.gmail.com>
Subject: Changing sd device from read only to read/write fails in 5.10 (BLKROSET)
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have USB devices that have a write enable/write protect feature.
A vendor specific SCSI command write enables a write protected drive.
In kernels prior to 5.10 I have been able to write-enable the drive
(by sending the vendor specific command to the SCSI generic device)
and then change the read only state of the sd block device by clearing
the read only state with BLKROSET.

This code used to work to tell the kernel that the device is
read/write (once enabled at the SCSI level). As of kernel 5.10 it does
not.

--------------------------

// other routine opens SCSI generic device
// like /dev/sg1 and sends vendor specific commands to change
// device from read only to read/write.
// The bit in the SCSI Mode Sense is read to confirm device is R/W

int readOnly = 0;
DeviceFD = open( /dev/sdb, O_RDONLY );
// Clear the RO flag in the block device
rtn0 = ioctl( DeviceFD, BLKROSET, &readOnly );
// This re-reads the device so the OS knows that it is now write-enabled
rtn1 = ioctl( DeviceFD, BLKRRPART, 0 );
close( DeviceFD );
// not sure this is necessary
chmod( /dev/sdb, S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH);

if( (DeviceFD = open( /dev/sdb, O_RDWR )) == ERROR ) {
   printf("success\n"); // <== use to work (open R/W)
} else {
   printf("failure");   // <== now fails under kernel 5.10
}
close( DeviceFD );

--------------------------

Can anyone tell me if the setting of the R/W state of the block device
has changed or if the method of signaling to the system that the write
state has changed is different in 5.10?
