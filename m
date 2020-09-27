Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFB227A247
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 20:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgI0SI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 14:08:26 -0400
Received: from smtprelay0121.hostedemail.com ([216.40.44.121]:54030 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726440AbgI0SIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 14:08:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 5A4B11801366C;
        Sun, 27 Sep 2020 18:08:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:355:379:973:988:989:1042:1260:1277:1311:1313:1314:1345:1437:1515:1516:1518:1535:1593:1594:1730:1747:1777:1792:1801:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3355:3865:3866:3868:3870:3871:3872:4050:4118:4250:4321:4384:4605:5007:6119:7875:7903:7974:9040:10004:10394:10848:11026:11233:11473:11657:11658:11914:12043:12050:12297:12438:12555:12760:12986:13439:14659:14877:21080:21324:21451:21627:21772:21789:21990:30009:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cord22_3a14a1a2717b
X-Filterd-Recvd-Size: 7920
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sun, 27 Sep 2020 18:08:23 +0000 (UTC)
Message-ID: <c267bbf55ee5a9bbbb5cb60fb6b1d2022df5af5a.camel@perches.com>
Subject: /* fallthrough */ -> fallthrough; stragglers
From:   Joe Perches <joe@perches.com>
To:     Gustavo Silva <silvagustavosilva@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 27 Sep 2020 11:08:22 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a sampling of a few fallthrough comments still in the tree
in -next as of today.

Done using:

$ git grep -i -10 -P '(?:/\*|//).*fall' -- '*.[ch]'

and visual inspection til I got tired of looking for more

---

drivers/net/usb/usbnet.c-       case -EPIPE:
drivers/net/usb/usbnet.c-               dev->net->stats.rx_errors++;
drivers/net/usb/usbnet.c-               usbnet_defer_kevent (dev, EVENT_RX_HALT);
drivers/net/usb/usbnet.c:               // FALLTHROUGH
drivers/net/usb/usbnet.c-
drivers/net/usb/usbnet.c-       /* software-driven interface shutdown */
drivers/net/usb/usbnet.c-       case -ECONNRESET:               /* async unlink */

arch/powerpc/perf/hv-24x7.c-static bool domain_is_valid(unsigned domain)
arch/powerpc/perf/hv-24x7.c-{
arch/powerpc/perf/hv-24x7.c-    switch (domain) {
arch/powerpc/perf/hv-24x7.c-#define DOMAIN(n, v, x, c)          \
arch/powerpc/perf/hv-24x7.c-    case HV_PERF_DOMAIN_##n:        \
arch/powerpc/perf/hv-24x7.c:            /* fall through */
arch/powerpc/perf/hv-24x7.c-#include "hv-24x7-domains.h"
arch/powerpc/perf/hv-24x7.c-#undef DOMAIN

arch/powerpc/platforms/52xx/mpc52xx_gpt.c-      case WDIOC_SETTIMEOUT:
arch/powerpc/platforms/52xx/mpc52xx_gpt.c-              ret = get_user(timeout, data);
arch/powerpc/platforms/52xx/mpc52xx_gpt.c-              if (ret)
arch/powerpc/platforms/52xx/mpc52xx_gpt.c-                      break;
arch/powerpc/platforms/52xx/mpc52xx_gpt.c-              real_timeout = (u64) timeout * 1000000000ULL;
arch/powerpc/platforms/52xx/mpc52xx_gpt.c-              ret = mpc52xx_gpt_do_start(gpt_wdt, real_timeout, 0, 1);
arch/powerpc/platforms/52xx/mpc52xx_gpt.c-              if (ret)
arch/powerpc/platforms/52xx/mpc52xx_gpt.c-                      break;
arch/powerpc/platforms/52xx/mpc52xx_gpt.c:              /* fall through and return the timeout */
arch/powerpc/platforms/52xx/mpc52xx_gpt.c-
arch/powerpc/platforms/52xx/mpc52xx_gpt.c-      case WDIOC_GETTIMEOUT:

arch/x86/events/core.c- case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
arch/x86/events/core.c-         /* All the metric events are mapped onto the fixed counter 3. */
arch/x86/events/core.c-         idx = INTEL_PMC_IDX_FIXED_SLOTS;
arch/x86/events/core.c:         /* fall through */
arch/x86/events/core.c- case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS-1:

arch/x86/kernel/e820.c- switch (type) {
arch/x86/kernel/e820.c: case E820_TYPE_RAM:             /* Fall through: */
arch/x86/kernel/e820.c- case E820_TYPE_RESERVED_KERN:   pr_cont("usable");                      break;
arch/x86/kernel/e820.c- case E820_TYPE_RESERVED:        pr_cont("reserved");                    break;
arch/x86/kernel/e820.c- case E820_TYPE_SOFT_RESERVED:   pr_cont("soft reserved");               break;
arch/x86/kernel/e820.c- case E820_TYPE_ACPI:            pr_cont("ACPI data");                   break;
arch/x86/kernel/e820.c- case E820_TYPE_NVS:             pr_cont("ACPI NVS");                    break;
arch/x86/kernel/e820.c- case E820_TYPE_UNUSABLE:        pr_cont("unusable");                    break;
arch/x86/kernel/e820.c: case E820_TYPE_PMEM:            /* Fall through: */
arch/x86/kernel/e820.c- case E820_TYPE_PRAM:            pr_cont("persistent (type %u)", type);  break;
arch/x86/kernel/e820.c- default:                        pr_cont("type %u", type);               break;

arch/x86/kernel/e820.c- switch (entry->type) {
arch/x86/kernel/e820.c: case E820_TYPE_RESERVED_KERN:   /* Fall-through: */
arch/x86/kernel/e820.c- case E820_TYPE_RAM:             return "System RAM";
arch/x86/kernel/e820.c- case E820_TYPE_ACPI:            return "ACPI Tables";
arch/x86/kernel/e820.c- case E820_TYPE_NVS:             return "ACPI Non-volatile Storage";
arch/x86/kernel/e820.c- case E820_TYPE_UNUSABLE:        return "Unusable memory";
arch/x86/kernel/e820.c- case E820_TYPE_PRAM:            return "Persistent Memory (legacy)";
arch/x86/kernel/e820.c- case E820_TYPE_PMEM:            return "Persistent Memory";
arch/x86/kernel/e820.c- case E820_TYPE_RESERVED:        return "Reserved";
arch/x86/kernel/e820.c- case E820_TYPE_SOFT_RESERVED:   return "Soft Reserved";

arch/x86/kernel/e820.c- switch (entry->type) {
arch/x86/kernel/e820.c: case E820_TYPE_RESERVED_KERN:   /* Fall-through: */
arch/x86/kernel/e820.c- case E820_TYPE_RAM:             return IORESOURCE_SYSTEM_RAM;
arch/x86/kernel/e820.c: case E820_TYPE_ACPI:            /* Fall-through: */
arch/x86/kernel/e820.c: case E820_TYPE_NVS:             /* Fall-through: */
arch/x86/kernel/e820.c: case E820_TYPE_UNUSABLE:        /* Fall-through: */
arch/x86/kernel/e820.c: case E820_TYPE_PRAM:            /* Fall-through: */
arch/x86/kernel/e820.c: case E820_TYPE_PMEM:            /* Fall-through: */
arch/x86/kernel/e820.c: case E820_TYPE_RESERVED:        /* Fall-through: */
arch/x86/kernel/e820.c: case E820_TYPE_SOFT_RESERVED:   /* Fall-through: */
arch/x86/kernel/e820.c- default:                        return IORESOURCE_MEM;

drivers/acpi/acpica/dswexec.c-                          }
drivers/acpi/acpica/dswexec.c-
drivers/acpi/acpica/dswexec.c:                          /* Fall through */
drivers/acpi/acpica/dswexec.c:                          /*lint -fallthrough */
drivers/acpi/acpica/dswexec.c-
drivers/acpi/acpica/dswexec.c-                  case AML_INT_EVAL_SUBTREE_OP:
drivers/acpi/acpica/dswexec.c-

drivers/acpi/acpica/dswload.c-                      (walk_state->
drivers/acpi/acpica/dswload.c-                       parse_flags & ACPI_PARSE_MODULE_LEVEL)) {
drivers/acpi/acpica/dswload.c-                          break;
drivers/acpi/acpica/dswload.c-                  }
drivers/acpi/acpica/dswload.c-
drivers/acpi/acpica/dswload.c:                  /*lint -fallthrough */
drivers/acpi/acpica/dswload.c-
drivers/acpi/acpica/dswload.c-          default:

(other acpica files exist, but acpica is autogenerated)

drivers/ata/pata_cmd64x.c-              case 1:
drivers/ata/pata_cmd64x.c-                      ppi[0] = &cmd_info[4];
drivers/ata/pata_cmd64x.c-                      ppi[1] = &cmd_info[4];
drivers/ata/pata_cmd64x.c:                      /* FALL THRU */
drivers/ata/pata_cmd64x.c-              /* Early revs have no CNTRL_CH0 */
drivers/ata/pata_cmd64x.c-              case 2:

drivers/atm/firestream.c-               switch (STATUS_CODE (qe)) {
drivers/atm/firestream.c-               case 0x1:
drivers/atm/firestream.c:                       /* Fall through for streaming mode */
drivers/atm/firestream.c-               case 0x2:/* Packet received OK.... */
drivers/atm/firestream.c-                       if (atm_vcc) {
drivers/atm/firestream.c-                               skb = pe->skb;
drivers/atm/firestream.c-                               pe->fp->n--;

drivers/block/rsxx/core.c-      case CARD_STATE_FAULT:
drivers/block/rsxx/core.c-              dev_crit(CARD_TO_DEV(card),
drivers/block/rsxx/core.c-                      "Hardware Fault reported!\n");
drivers/block/rsxx/core.c:              /* Fall through. */
drivers/block/rsxx/core.c-
drivers/block/rsxx/core.c-      /* Everything else, detach DMA interface if it's attached. */
drivers/block/rsxx/core.c-      case CARD_STATE_SHUTDOWN:

etc...


