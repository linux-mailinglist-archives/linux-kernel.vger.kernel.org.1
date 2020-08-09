Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B1723FC46
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Aug 2020 05:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgHIDKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Aug 2020 23:10:08 -0400
Received: from mail.cock.li ([37.120.193.124]:56550 "EHLO mail.cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgHIDKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 23:10:08 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1596942603; bh=GjTGfoW9F+VaziRLEHlDkhHQnJaM8xdQcIqswe3AOsc=;
        h=Date:From:To:Cc:Subject:From;
        b=RzVfoobygpsiz2644bqiA5GQbK77LhvITYczTd9+/dvw7GGfQ+Kp3ft8oXOayuWfV
         ZgNIt7bmro8b3juLuuecdzD9WHiiDNV0NaJ/J2uKlqZs01nZ4q+56/LwjD1cyauiIg
         1CbRGDDT+p3kXDkCGKRGtMmX3Jd7JoWatIyqi8yXNLwUeW+hMZ/cDbQki0zk/P9wwn
         qrH4gyv9nQmFRYhUcGkKNfpVAnmLgwzv/2lLXca0O9xTK7veBqGbCcAFiPLwkxnRQ9
         BBedOlVvB1bLj0sLnDOkMtz6E/1K1O8lmQtAiFRZ5JF6XOST5vHfnpNUPMOsiGqOjD
         aZ7kxl99zr5ig==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 09 Aug 2020 03:10:02 +0000
From:   nipponmail@firemail.cc
To:     bruce@perens.com
Cc:     linux-kernel@vger.kernel.org, esr@thyrsus.com, moglen@columbia.edu,
        blukashev@sempervictus.com, tcallawa@redhat.com, editor@lwn.net,
        skraw.ml@ithnet.com, torvalds@osdl.org, rms@gnu.org
Subject: Bradly Spengler interview (GRSecurity) (Blatant GPL violators vs GCC
 and Linux Kernel)
Message-ID: <dddaf3541c2a9c01f9f7d08ec6b0bb8f@firemail.cc>
X-Sender: nipponmail@firemail.cc
User-Agent: Roundcube Webmail/1.3.10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thought you might be interested:
https://www.youtube.com/watch?v=rv3a2tzUTn4

GRSecurity violates both the Linux kernel's copyright and the GCC 
copyright by forbidding redistribution of the patches (in their Access 
Agreement): which are non-seperable derivative works of the kernel and 
(in the case of the GCC plugins) GCC. Yes: threatening consequences if a 
licensee redistributes is a restraint on the "rights" given by the 
original copyright owners. Those "plugins" he is talking about as-well 
as the kernel patch violate the GPLv2. The GPLv2 _FORBIDS_ adding 
additional clauses not-within the GPL between the derivative-licensee 
and the down-the-line licensee. Bradly Spengler / OpenSourceSecurity are 
violating this stipulation, blatantly, in writing. They are also 
violating the "no additional restrictions" stipulation in the GPLv2. 
They ARE violating the Linux and the GCC copyright.
