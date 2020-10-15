Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD728F09A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 13:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbgJOLCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 07:02:53 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:51839 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbgJOLCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 07:02:51 -0400
Received: from torchwood.molgen.mpg.de (torchwood.molgen.mpg.de [141.14.21.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kreitler)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4DE3420646213;
        Thu, 15 Oct 2020 13:02:49 +0200 (CEST)
Subject: Re: Linux 5.9: smartpqi: controller is offline: status code 0x6100c
To:     Paul Menzel <pmenzel@molgen.mpg.de>
References: <bc10fad1-2353-7326-c782-7a45882fd791@molgen.mpg.de>
Cc:     linux-kernel@vger.kernel.org
From:   Thomas Kreitler <kreitler@molgen.mpg.de>
Message-ID: <c896f44d-637b-58ff-46ab-efb1891ca16c@molgen.mpg.de>
Date:   Thu, 15 Oct 2020 13:02:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <bc10fad1-2353-7326-c782-7a45882fd791@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

The meaning behind 0x6100c can be found rather easily.

 From drivers/scsi/smartpqi/smartpqi.h comes the main part

   #define PQI_DATA_IN_OUT_PCIE_COMPLETION_TIMEOUT  0x61

the rest looks like additional status bytes reported whilst the error is 
processed.

My conclusion is that something happened on the PCIe bus.

Best,
	Thomas


P.S.. Maybe it's worth mentioning, that the machine in question is 
fitted with two Microsemi HBA-1100 controllers.

On 2020-10-14 23:47, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> With Linux 5.9 and
> 
> 
>      $ lspci -nn -s 89:
>      89:00.0 Serial Attached SCSI controller [0107]: Adaptec Smart 
> Storage PQI 12G SAS/PCIe 3 [9005:028f] (rev 01)
>      $ more 
> /sys/devices/pci0000:88/0000:88:00.0/0000:89:00.0/host15/scsi_host/host15/driver_version 
> 
>      1.2.8-026
>      $ more 
> /sys/devices/pci0000:88/0000:88:00.0/0000:89:00.0/host15/scsi_host/host15/firmware_version 
> 
>      2.62-0
> 
> the controller went offline with status code 0x6100c.
> 
>> Oct 14 14:54:01 done.molgen.mpg.de kernel: smartpqi 0000:89:00.0: 
>> controller is offline: status code 0x6100c
>> Oct 14 14:54:01 done.molgen.mpg.de kernel: smartpqi 0000:89:00.0: 
>> controller offline
>> Oct 14 14:54:01 done.molgen.mpg.de kernel: sd 15:0:2:0: [sdu] tag#709 
>> FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=6s
>> Oct 14 14:54:01 done.molgen.mpg.de kernel: sd 15:0:15:0: [sdah] 
>> tag#274 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK 
>> cmd_age=6s
>> Oct 14 14:54:01 done.molgen.mpg.de kernel: sd 15:0:4:0: [sdw] tag#516 
>> FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=6s
>> Oct 14 14:54:01 done.molgen.mpg.de kernel: sd 15:0:4:0: [sdw] tag#516 
>> CDB: Write(10) 2a 00 0d e6 9e 88 00 00 01 00
>> Oct 14 14:54:01 done.molgen.mpg.de kernel: blk_update_request: I/O 
>> error, dev sdw, sector 1865741376 op 0x1:(WRITE) flags 0x0 phys_seg 1 
>> prio class 0
>> Oct 14 14:54:01 done.molgen.mpg.de kernel: sd 15:0:0:0: [sds] tag#529 
>> FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=6s
>> Oct 14 14:54:01 done.molgen.mpg.de kernel: sd 15:0:0:0: [sds] tag#529 
>> CDB: Write(10) 2a 00 29 4e e8 ff 00 00 01 00
>> Oct 14 14:54:01 done.molgen.mpg.de kernel: blk_update_request: I/O 
>> error, dev sds, sector 5544298488 op 0x1:(WRITE) flags 0x0 phys_seg 1 
>> prio class 0
>> Oct 14 14:54:01 done.molgen.mpg.de kernel: sd 15:0:0:0: [sds] tag#627 
>> FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=6s
>> Oct 14 14:54:01 done.molgen.mpg.de kernel: sd 15:0:0:0: [sds] tag#627 
>> CDB: Read(10) 28 00 5d df 2c 04 00 00 04 00
>> Oct 14 14:54:01 done.molgen.mpg.de kernel: blk_update_request: I/O 
>> error, dev sds, sector 12599255072 op 0x0:(READ) flags 0x1000 phys_seg 
>> 1 prio class
>> Oct 14 14:54:01 done.molgen.mpg.de kernel: sd 15:0:5:0: [sdx] tag#567 
>> FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=6s
>> Oct 14 14:54:01 done.molgen.mpg.de kernel: sd 15:0:5:0: [sdx] tag#567 
>> CDB: Write(10) 2a 00 21 4e ce 04 00 00 04 00
> 
> How can the status code 0x6100c be deciphered?
> 
> 
> Kind regards,
> 
> Paul

-- 
Thomas Kreitler - Information Retrieval
kreitler@molgen.mpg.de
49/30/8413 1702
