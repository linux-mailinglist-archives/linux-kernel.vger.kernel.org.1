Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E296B291915
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 21:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgJRTF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 15:05:57 -0400
Received: from bobcat.rjmcmahon.com ([45.33.58.123]:35662 "EHLO
        bobcat.rjmcmahon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgJRTF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 15:05:56 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Oct 2020 15:05:56 EDT
Received: by bobcat.rjmcmahon.com (Postfix, from userid 99)
        id DBF3A1B27D; Sun, 18 Oct 2020 14:57:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 bobcat.rjmcmahon.com DBF3A1B27D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjmcmahon.com;
        s=bobcat; t=1603047463;
        bh=xji6pABLtqhTqNfnLvc//8EFuzWRfvaZ3e/b2wHzxRI=;
        h=Date:From:To:Subject:From;
        b=ftk1SynqTbu4+ZH4YUWYy4OYUegV7veCyxYuKZP8puqVRB1q8D7yr1W/chE/fR+H+
         rX/4cAm0SvIi1nNkCsyKwK3eVQceZ2r+HshfLZwNROB/w5VV7H+7q+3SEWARzX3AYq
         PLf/i2xNPXpwiNPX+wj836I35FBQyaRpIrU+Hd68=
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on bobcat.rjmcmahon.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.2
Received: from mail.rjmcmahon.com (bobcat.rjmcmahon.com [45.33.58.123])
        by bobcat.rjmcmahon.com (Postfix) with ESMTPA id AB7891B261
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 14:57:42 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 bobcat.rjmcmahon.com AB7891B261
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjmcmahon.com;
        s=bobcat; t=1603047462;
        bh=xji6pABLtqhTqNfnLvc//8EFuzWRfvaZ3e/b2wHzxRI=;
        h=Date:From:To:Subject:From;
        b=ByNWeLiIjnftruMSdU/+kQ+JpnhjPNs0NNk2AGuU9v4GxHYlig4jhZGg1XRB1M5ff
         zkVKnLaGnYVNtjYBxUs4lopLeivHQRfk+MNDQeertsSFMiikEiWYzKCwotiTlGsoQB
         2G7xr0DLopPIWr41WxcmkFIqo3KIysWbvihb1C2Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 18 Oct 2020 11:57:42 -0700
From:   rjmcmahon <rjmcmahon@rjmcmahon.com>
To:     linux-kernel@vger.kernel.org
Subject: iperf 2.0.14 in early field test (EFT) phase
Message-ID: <f3e1354ffb89f854cc8f9d82015726b2@rjmcmahon.com>
X-Sender: rjmcmahon@rjmcmahon.com
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Sorry for the spam - trying to reach interested parties.

Just a heads up that iperf 2.0.14 is in early field test phase. Lots of 
new features around write to read latencies and others. Also, 
full-duplex, same socket testing now supported too.  Use -e to get the 
enhanced output. Man page should be in reasonable shape.  Release notes 
as of today:

https://sourceforge.net/projects/iperf2/

2.0.14 change set (as of October 17th, 2020)
----------------------------------------
o scaling improvements for -P, i.e. improved support for large numbers 
of traffic threads
o major code refactoring (see doc/DESIGN_NOTES) for maintainability, 
extensibilty, performance, scaling, memory usage
o support for full duplex traffic using --full-duplex
o support for reverse traffic using --reverse
o support for role-reversal character of asterisk in the transfer id
o transfer id now an incrementing integer and no longer the socket id
o support for TCP connect only tests with --connect-only
o isochronous support compiled in by default, must use config to disable
o support --isochronous for both UDP or TCP traffic to simulate video 
streams
o use of clock_nanosleep when supported to schedule isochronous burst 
starts, otherwise use nanosleep delay
o support for --trip-times indicating the client and server clocks are 
synchronized to an accuracy sufficient, note: consider the use of 
precision time protocol as well as ask your data center to provide 
access to a GPS disciplined reference time source
o support for --trip-times with -d and -r bidirectional tests
o output TCP connect times (3WHS) in connect reports
o support for application level tcp connect retries via 
--connect-retries n
o rate-limited options of -b and --fq-rate supported for unidirectional, 
full duplex and reverse traffic
o reporter thread designed to automatically cause packet reports to 
aggregate - mitigating and hopefully removing thread thrashing
o support for frame or burst based reporting or sampling vs time based 
via -i [f|F] (experimental)
o support for UDP traffic only from client to server with --no-udp-fin
o support for write to read latencies (UDP and TCP) with --trip-times
o support for sum only outputs with --sum-only
o support for little's law calculations in --trip-time outputs
o support for --txstart-time <epoch-time> to schedule client traffic 
start, timestamp support microseconds, e.g. unix $(expr $(date +%s) + 
1).$(date +%N)
o support for --txdelay-time to insert delay between TCP three way 
handshake (3WHS) and data transfer
o support for --no-connect-sync which disables transmit traffic start 
synchronization when -P is used, defaults to synchronized
o option of --full-duplex implementation uses a barrier on the client 
side to synchronize full duplex traffic
o no limits to group sum reports, i.e. all clients will get its own sum 
report per a server
o improved report timestamps, e.g. end to end or client and server based 
timestamps with --trip-times
o improved settings messaging
o improved messaging for --tcp-congestion or -Z
o re-implemented -U for single UDP server with minimal threading 
interactions
o re-implemented -1 or --singleclient where server will serialize 
traffic runs
o warning message if the test were likely CPU bound instead of network 
i/o bound
o fix the case when -P <value> is set on the server such that summing 
output is displayed
o multicast listener will autoset -U (single server), e.g -P > 1 not 
supported for multicast
o multicast listener no longer busy drops multicast packets during 
traffic test, i.e. only server thread receives them
o immediate bail out on mutually exclusive command line options
o man page updates with examples
o tested with 1000's of traffic streams, WiFi, 10G and 100G


Thanks,
Bob McMahon
