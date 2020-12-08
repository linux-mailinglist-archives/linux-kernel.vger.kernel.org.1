Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7B72D2778
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgLHJYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:24:51 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:57611 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbgLHJYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:24:50 -0500
Received: from [192.168.0.3] (unknown [95.90.244.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id AE6BC2064713F;
        Tue,  8 Dec 2020 10:24:08 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Pass modules to Linux kernel without initrd
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Message-ID: <6fbaf375-389d-6581-55a1-78bbe2852e2d@molgen.mpg.de>
Date:   Tue, 8 Dec 2020 10:24:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Trying to reduce the boot time of standard distributions, I would like 
to get rid of the initrd. The initrd is for mounting the root file 
system and on most end user systems with standard distributions that 
means loading the bus driver for the drive and the file system driver. 
Everyone could build their own Linux kernel and build the drivers into 
the Linux kernel, but most users enjoy using the distribution Linux 
kernel, which build the drivers as modules to support a lot of systems. 
(I think Fedora builds the default file system driver (of the installer) 
into the Linux kernel.)

A custom minimal initrd init script only loading the modules would also 
work, but as libkmod depends on libcrypto, which as a shared library is 
already three megabytes in size. Building libkmod statically would mean 
for distributions, that you need hooks to rebuild libkmod each time 
OpenSSL is updated (to get the changes).

Similar to passing firmware and microcode update files to Linux or 
building these into the Linux kernel image, would it be possible to 
append the required modules to the Linux kernel image, and Linux would 
load these?

Probably you are going to say, that is not how it works, but maybe I am 
lucky and you know a solution, or could point me to the right direction 
how such a think could be implemented.


Kind regards,

Paul
