Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BB429F66B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgJ2UtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:49:18 -0400
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:5813 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgJ2UtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:49:18 -0400
Received: from thorin.petrovitsch.priv.at (80-110-108-194.cgn.dynamic.surfer.at [80.110.108.194])
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id 09TKmcth005210
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 29 Oct 2020 21:48:39 +0100
Message-ID: <c47a429f287a0a085a54483df0994fae58d4c356.camel@petrovitsch.priv.at>
Subject: Re: SIGHUP on connect
From:   Bernd Petrovitsch <bernd@petrovitsch.priv.at>
To:     "Michael J. Baars" <mjbaars1977.linux-kernel@cyberfiber.eu>,
        linux-kernel@vger.kernel.org
Date:   Thu, 29 Oct 2020 21:48:38 +0100
References: <0e0db8180bc560c9ebaeb42957cf2ecc365cc80d.camel@cyberfiber.eu>
         <8b693bb1-1711-5289-5bc8-e5955da21968@petrovitsch.priv.at>
         <2ce68928bcec23a0f41864f4f0fb55f2dd81d739.camel@cyberfiber.eu>
In-Reply-To: <2ce68928bcec23a0f41864f4f0fb55f2dd81d739.camel@cyberfiber.eu>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-DCC-x.dcc-servers-Metrics: esgaroth.tuxoid.at 104; Body=2 Fuz1=2 Fuz2=2
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.1
X-Spam-Report: *  0.0 UNPARSEABLE_RELAY Informational: message has unparseable relay lines
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on esgaroth.tuxoid.at
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

On 29/10/2020 14:10, Michael J. Baars wrote:
[...] 
> According to manual page socket(7), SO_REUSEADDR allows for local addresses to be reused for binding. I've tested this socket option with the WAN address, it
> appears the problem is solved for both local and non-local connections.

Yup.

> I also found the the SO_LINGER socket option to be useful in some way. By default, SO_LINGER is set to 0, so you would think that lingering connections were out
> of the question. However, an enabled linger with a l_onoff = 1 and a l_linger = 0 seems to work a lot better than a disabled linger with a l_onoff = 0 and a
> l_linger = 0.
> 
> Which option would you use?

I never used SO_LINGER before.

From the description in `man 7 socket`, active SO_LINGER just
makes shutdown() to block if not all data has been transmitted
(and ACKed?).
close() on a socket calls shutdown() automatically (unless
the shutdown() has been already called).

The timeout which you're application runs into
applies after shutting down/closing the connection.

MfG,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
There is no cloud, just other people computers. - FSFE
                     LUGA : http://www.luga.at


