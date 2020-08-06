Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE06323D4EC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 02:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgHFA75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 20:59:57 -0400
Received: from nl101-3.vfemail.net ([149.210.219.33]:18855 "EHLO
        nl101-3.vfemail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHFA74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 20:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=vfemail.net; h=date:from
        :to:cc:subject:message-id:mime-version:content-type
        :content-transfer-encoding; s=2018; bh=WWCRr53IoGT4XDcX26DOWVck1
        l+LodmOEfnka3F1HDI=; b=k3LxGPTczKPElXvL5tA64MEGAv3mNjLGMhFBSEMOe
        1gdl/4XXrx3TCXN83GpUgKr1hx6g85R1CvACr045l/eU6bdn/AKytudyfFgIzFTw
        qQk/IGCYoXhWXymQWOHXENm23OqueLcpkew34F1Z7/AuG4W0EBviQ5s07d6nFYch
        Do=
Received: (qmail 84571 invoked from network); 6 Aug 2020 00:59:56 -0000
Received: by simscan 1.4.0 ppid: 84558, pid: 84567, t: 0.2956s
         scanners:none
Received: from unknown (HELO d3d3MTkyLnZmZW1haWwubmV0) (aGdudGt3aXNAdmZlbWFpbC5uZXQ=@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 6 Aug 2020 00:59:56 -0000
Date:   Wed, 5 Aug 2020 20:59:24 -0400
From:   David Niklas <Hgntkwis@vfemail.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Is anyone else getting a bad signature from kernel.org's 5.8
 sources+Greg's sign?
Message-ID: <20200805205924.1f646d45@Phenom-II-x6.niklas.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I downloaded the kernel sources from kernel.org using curl, then
opera, and finally lynx (to rule out an html parsing bug). I did the same
with the sign and I keep getting:

%  gpg2 --verify linux-5.8.tar.sign linux-5.8.tar.xz
gpg: Signature made Mon Aug  3 00:19:13 2020 EDT
gpg:                using RSA key 647F28654894E3BD457199BE38DBBDC86092693E
gpg: BAD signature from "Greg Kroah-Hartman
<gregkh@linuxfoundation.org>" [unknown]

I did refresh all the keys just in case.
I believe this is important so I'm addressing this to the signer and only
CC'ing the list.

If I'm made some simple mistake, feel free to send SIG666 to my terminal.
I did re-read the man page just in case.

Thanks,
David
