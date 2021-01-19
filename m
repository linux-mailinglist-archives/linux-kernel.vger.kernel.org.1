Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639C42FC079
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbhAST7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729920AbhAST7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:59:09 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFA8C061573;
        Tue, 19 Jan 2021 11:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=CVukzLoC6izto3DL8Ksb3vKHfyZG+Fn4DMqY6xEK3zI=; b=kUL68LCVRK1oAGBEfAeMIJ8S21
        HhDyacbdMKUqivDjMTCXtHsdvwGSmZNSmKJr/j6+M3MaNCIKrfswJT5wwyowIsoL9WHD0wQ6q2tTK
        7J+bHV9/R7egYt4b1Z9p+mXKWU3iCHRxrbsppzHbfroWkzPsBBAdsm2ho0i5HUsqM/t49KUC/C/ck
        km3OVG9GVXbke4rAGT3wCPNLGTvBxyEp3ncwD8dLwGUG88Z7zDE04G7xfKtdDYmAI6NbXkaPXes74
        EivoT4D+hwDc/eQ/UZno1/9yDpOAYfUCq3Y6SX/Wx1QAJ4Btq29Fr3ovdypYVIgeWN+9EtaM2o7ED
        gJZCQ/2Q==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l1x8y-0006be-4x; Tue, 19 Jan 2021 19:58:24 +0000
Subject: Re: [PATCH v2 20/34] xlink-core: Add xlink core driver xLink
To:     mgross@linux.intel.com, markgross@kernel.org, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        linux-doc@vger.kernel.org
References: <20210108212600.36850-1-mgross@linux.intel.com>
 <20210108212600.36850-21-mgross@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e52e4b7a-61f7-ed15-bc3b-466fc1d70b21@infradead.org>
Date:   Tue, 19 Jan 2021 11:58:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210108212600.36850-21-mgross@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doc comments only:

On 1/8/21 1:25 PM, mgross@linux.intel.com wrote:
> diff --git a/Documentation/vpu/xlink-core.rst b/Documentation/vpu/xlink-core.rst
> new file mode 100644
> index 000000000000..1c471ec803d3
> --- /dev/null
> +++ b/Documentation/vpu/xlink-core.rst
> @@ -0,0 +1,81 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============================
> +xLink-core software subsystem
> +=============================
> +
> +The purpose of the xLink software subsystem is to facilitate communication
> +between multiple users on multiple nodes in the system.
> +
> +There are three types of xLink nodes:
> +
> +1. Remote Host: this is an external IA/x86 host system that is only capable of
> +   communicating directly to the Local Host node on VPU 2.x products.
> +2. Local Host: this is the ARM core within the VPU 2.x  SoC. The Local Host can
> +   communicate upstream to the Remote Host node, and downstream to the VPU IP
> +   node.
> +3. VPU IP: this is the Leon RT core within the VPU 2.x SoC. The VPU IP can only
> +   communicate upstream to the Local Host node.
> +
> +xLink provides a common API across all interfaces for users to access xLink
> +functions and provides user space APIs via an IOCTL interface implemented in
> +the xLink core.
> +
> +xLink manages communications from one interface to another and provides routing
> +of data through multiple channels across a single physical interface.
> +
> +It exposes a common API across all interfaces at both kernel and user levels
> +for processes/applications to access.
> +
> +It has typical API types (open, close, read, write) that you would associate
> +with a communication interface.
> +
> +It also has other APIs that are related to other functions that the device can
> +perform, e.g. boot, reset get/set device mode.
> +The driver is broken down into 4 source files.
> +
> +xlink-core:
> +Contains driver initialization, driver API and IOCTL interface (for user
> +space).
> +
> +xlink-multiplexer:
> +The Multiplexer component is responsible for securely routing messages through
> +multiple communication channels over a single physical interface.
> +
> +xlink-dispatcher:
> +The Dispatcher component is responsible for queueing and handling xLink
> +communication requests from all users in the system and invoking the underlying
> +platform interface drivers.
> +
> +xlink-platform:
> +provides abstraction to each interface supported (PCIe, USB, IPC, etc).
> +
> +Typical xLink transaction (simplified):
> +When a user wants to send data across an interface via xLink it firstly calls
> +xlink connect which connects to the relevant interface (PCIe, USB, IPC, etc.)
> +and then xlink open channel.
> +
> +Then it calls xlink write function, this takes the data, passes it to the

                             function. This takes

> +kernel which packages up the data and channel and then adds it to a transmit
> +queue.
> +
> +A separate thread reads this transaction queue and pops off data if available
> +and passes the data to the underlying interface (e.g. PCIe) write function.
> +Using this thread provides serialization of transactions and decouples the user
> +write from the platform write.
> +
> +On the other side of the interface, a thread is continually reading the
> +interface (e.g. PCIe) via the platform interface read function and if it reads
> +any data it adds it to channel packet container.
> +
> +The application at this side of the interface will have called xlink connect,
> +opened the channel and called xlink read function to read data from the
> +interface and if any exists for that channel , the data gets popped from the

                                        channel, the

> +channel packet container and copied from kernel space to user space buffer
> +provided by the call.
> +
> +xLink can handle API requests from multi-process and multi-threaded
> +application/processes.
> +
> +xLink maintains 4096 channels per device connected (via xlink connect) and
> +maintains a separate channel infrastructure for each device.


-- 
~Randy
"He closes his eyes and drops the goggles.  You can't get hurt
by looking at a bitmap.  Or can you?"
(Neal Stephenson: Snow Crash)
