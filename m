Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9F52E01BD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 21:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgLUU52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 15:57:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbgLUU51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 15:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608584157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GBYvum/LpbySBqgsGRpCjwNe3HgJ8ax3uEwNr0XMDVY=;
        b=N5RgNaHjbQvkx7avE5RyXmuebxvEx21y1IgONiN/aWNHtkyGArKfAAKmru/owICRF7EIGK
        LrHja9yf0pwsCa3saDD4xHvQhxpgWEJpDwkYTRnppUdAk0NVaPGh7yUk78w/MeAEuIYcTx
        g0AycdD95bjLcEsOHMarsWZmEr0trOg=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-LZ8Cw3T4MyKhlHTfWrD8fg-1; Mon, 21 Dec 2020 15:55:55 -0500
X-MC-Unique: LZ8Cw3T4MyKhlHTfWrD8fg-1
Received: by mail-oo1-f71.google.com with SMTP id o65so4339721ooo.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 12:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GBYvum/LpbySBqgsGRpCjwNe3HgJ8ax3uEwNr0XMDVY=;
        b=J9Etx33yLueA/qF4HpqdCsUGTmb/urgPma/PBoW6sHxlvs1WdPp5SbQSXEbXArrOEq
         6c0/nI0VU/5BvH8+fsR0vNt6TG+SuLpPrXiFk98Npu00duf9+Q0SPo4L7CYB3wxc8Yxk
         yXnPguvGOwMdg3XNlSnJ4JPjPPH9EAU574unX4CW9NyIjgEnAl8MbNOzzZ6ogsk1u1Mp
         nlkZ2GidBiVRZNrYf/27LVEy2hDrnWO6FZLFNYZn18x6s6Xk4UX0vwKEt+qKoU2HdKvC
         Dx1OII7Vcb/n//FuE+k1qv2UliyJzP0qnwUArKudCpox5vA+OuYJebmNxQddOkJ8Vnu4
         +a8g==
X-Gm-Message-State: AOAM53153i/Z57qptudVDqDld5NMjK17Qrf4+5zSG0WRoWl1fxU6sSfW
        FCHAWL9abWrBua/6Atkjq6bGufK88SHNanp/6xq5AIsAffDwsHKJ2lf6pPz+7EzK1aCGwPL6C3l
        q7ons8GvZ0iGKVqvAiD5/27L/4e4LALbRCBC02FwtO1QvR6BcCQF8e6yIo5gLBgGNdM1SXNs=
X-Received: by 2002:a05:6830:1605:: with SMTP id g5mr13431859otr.369.1608584153300;
        Mon, 21 Dec 2020 12:55:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKLTsmdiKiyG2Rn/TfD8u00fJ0tTK7ns9mQopUQecOdmagzefpL/qCq1w7B+rcQ8XP7P+NAg==
X-Received: by 2002:a05:6830:1605:: with SMTP id g5mr13431819otr.369.1608584152110;
        Mon, 21 Dec 2020 12:55:52 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h7sm4072167otq.21.2020.12.21.12.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 12:55:51 -0800 (PST)
Subject: Re: [PATCH] usb: musb: add printf attribute to log function
To:     Joe Perches <joe@perches.com>, b-liu@ti.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201221162547.3756889-1-trix@redhat.com>
 <6e214d120372681fd9bfb60bb1ac880248d8924f.camel@perches.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <56cf4fed-1233-ff3d-a04d-3c8d7d495979@redhat.com>
Date:   Mon, 21 Dec 2020 12:55:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <6e214d120372681fd9bfb60bb1ac880248d8924f.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/21/20 12:33 PM, Joe Perches wrote:
> On Mon, 2020-12-21 at 08:25 -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> Attributing the function allows the compiler to more thoroughly
>> check the use of the function with -Wformat and similar flags.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  drivers/usb/musb/musb_debug.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/musb/musb_debug.h b/drivers/usb/musb/musb_debug.h
>> index e5b3506c7b3f..dfc0d02695fa 100644
>> --- a/drivers/usb/musb/musb_debug.h
>> +++ b/drivers/usb/musb/musb_debug.h
>> @@ -17,6 +17,7 @@
>>  #define INFO(fmt, args...) yprintk(KERN_INFO, fmt, ## args)
>>  #define ERR(fmt, args...) yprintk(KERN_ERR, fmt, ## args)
>>  
>>
>> +__printf(2, 3)
>>  void musb_dbg(struct musb *musb, const char *fmt, ...);
> Maybe convert all the WARN/INFO/ERR uses to dev_<level> equivalents too?
>
> Use more typical logging styles:
>
> o Add musb_<level> macros that use dev_<level>
> o Add struct musb * to musb_<level> calls
> o Remove __func__ and __LINE__ uses
> o Remove newlines from formats and add to macros for consistency with musb_dbg
> o Remove unnecessary newlines from musb_dbg uses
> o Coalesce formats and align arguments

I will looking into cleaning these up.

The propose of this and similar changes today was to add the __printf so the the %hhx cleaner would find them.

Thanks for the suggestion,

Tom

>
> ---
>
> (compiled x86-64 only, untested)
>
>  drivers/usb/musb/am35x.c           |   2 +-
>  drivers/usb/musb/cppi_dma.c        | 160 ++++++++++++++++++-------------------
>  drivers/usb/musb/da8xx.c           |   2 +-
>  drivers/usb/musb/davinci.c         |   7 +-
>  drivers/usb/musb/musb_core.c       |  74 ++++++++---------
>  drivers/usb/musb/musb_cppi41.c     |   2 +-
>  drivers/usb/musb/musb_debug.h      |  14 ++--
>  drivers/usb/musb/musb_dsps.c       |   2 +-
>  drivers/usb/musb/musb_gadget.c     |  76 +++++++++---------
>  drivers/usb/musb/musb_gadget_ep0.c |  33 ++++----
>  drivers/usb/musb/musb_host.c       |  98 +++++++++++------------
>  drivers/usb/musb/musb_virthub.c    |   4 +-
>  drivers/usb/musb/musbhsdma.c       |  20 ++---
>  drivers/usb/musb/tusb6010.c        |  24 +++---
>  drivers/usb/musb/tusb6010_omap.c   |   4 +-
>  drivers/usb/musb/ux500_dma.c       |   4 +-
>  16 files changed, 256 insertions(+), 270 deletions(-)
>
> diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
> index 660641ab1545..39d830e633c1 100644
> --- a/drivers/usb/musb/am35x.c
> +++ b/drivers/usb/musb/am35x.c
> @@ -260,7 +260,7 @@ static irqreturn_t am35x_musb_interrupt(int irq, void *hci)
>  			musb->int_usb &= ~MUSB_INTR_VBUSERROR;
>  			musb->xceiv->otg->state = OTG_STATE_A_WAIT_VFALL;
>  			mod_timer(&musb->dev_timer, jiffies + POLL_SECONDS * HZ);
> -			WARNING("VBUS error workaround (delay coming)\n");
> +			musb_warn(musb, "VBUS error workaround (delay coming)");
>  		} else if (drvvbus) {
>  			MUSB_HST_MODE(musb);
>  			musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
> diff --git a/drivers/usb/musb/cppi_dma.c b/drivers/usb/musb/cppi_dma.c
> index edb5b63d7063..021395de3b38 100644
> --- a/drivers/usb/musb/cppi_dma.c
> +++ b/drivers/usb/musb/cppi_dma.c
> @@ -317,7 +317,7 @@ cppi_channel_allocate(struct dma_controller *c,
>  	 */
>  	if (cppi_ch->hw_ep)
>  		musb_dbg(musb, "re-allocating DMA%d %cX channel %p",
> -				index, transmit ? 'T' : 'R', cppi_ch);
> +			 index, transmit ? 'T' : 'R', cppi_ch);
>  	cppi_ch->hw_ep = ep;
>  	cppi_ch->channel.status = MUSB_DMA_STATUS_FREE;
>  	cppi_ch->channel.max_len = 0x7fffffff;
> @@ -338,7 +338,7 @@ static void cppi_channel_release(struct dma_channel *channel)
>  	tibase = c->controller->tibase;
>  	if (!c->hw_ep)
>  		musb_dbg(c->controller->controller.musb,
> -			"releasing idle DMA channel %p", c);
> +			 "releasing idle DMA channel %p", c);
>  	else if (!c->transmit)
>  		core_rxirq_enable(tibase, c->index + 1);
>  
> @@ -357,23 +357,21 @@ cppi_dump_rx(int level, struct cppi_channel *c, const char *tag)
>  	musb_ep_select(base, c->index + 1);
>  
>  	musb_dbg(c->controller->controller.musb,
> -		"RX DMA%d%s: %d left, csr %04x, "
> -		"%08x H%08x S%08x C%08x, "
> -		"B%08x L%08x %08x .. %08x",
> -		c->index, tag,
> -		musb_readl(c->controller->tibase,
> -			DAVINCI_RXCPPI_BUFCNT0_REG + 4 * c->index),
> -		musb_readw(c->hw_ep->regs, MUSB_RXCSR),
> -
> -		musb_readl(&rx->rx_skipbytes, 0),
> -		musb_readl(&rx->rx_head, 0),
> -		musb_readl(&rx->rx_sop, 0),
> -		musb_readl(&rx->rx_current, 0),
> -
> -		musb_readl(&rx->rx_buf_current, 0),
> -		musb_readl(&rx->rx_len_len, 0),
> -		musb_readl(&rx->rx_cnt_cnt, 0),
> -		musb_readl(&rx->rx_complete, 0)
> +		 "RX DMA%d%s: %d left, csr %04x, %08x H%08x S%08x C%08x, B%08x L%08x %08x .. %08x",
> +		 c->index, tag,
> +		 musb_readl(c->controller->tibase,
> +			    DAVINCI_RXCPPI_BUFCNT0_REG + 4 * c->index),
> +		 musb_readw(c->hw_ep->regs, MUSB_RXCSR),
> +
> +		 musb_readl(&rx->rx_skipbytes, 0),
> +		 musb_readl(&rx->rx_head, 0),
> +		 musb_readl(&rx->rx_sop, 0),
> +		 musb_readl(&rx->rx_current, 0),
> +
> +		 musb_readl(&rx->rx_buf_current, 0),
> +		 musb_readl(&rx->rx_len_len, 0),
> +		 musb_readl(&rx->rx_cnt_cnt, 0),
> +		 musb_readl(&rx->rx_complete, 0)
>  		);
>  }
>  
> @@ -387,21 +385,19 @@ cppi_dump_tx(int level, struct cppi_channel *c, const char *tag)
>  	musb_ep_select(base, c->index + 1);
>  
>  	musb_dbg(c->controller->controller.musb,
> -		"TX DMA%d%s: csr %04x, "
> -		"H%08x S%08x C%08x %08x, "
> -		"F%08x L%08x .. %08x",
> -		c->index, tag,
> -		musb_readw(c->hw_ep->regs, MUSB_TXCSR),
> -
> -		musb_readl(&tx->tx_head, 0),
> -		musb_readl(&tx->tx_buf, 0),
> -		musb_readl(&tx->tx_current, 0),
> -		musb_readl(&tx->tx_buf_current, 0),
> -
> -		musb_readl(&tx->tx_info, 0),
> -		musb_readl(&tx->tx_rem_len, 0),
> -		/* dummy/unused word 6 */
> -		musb_readl(&tx->tx_complete, 0)
> +		 "TX DMA%d%s: csr %04x, H%08x S%08x C%08x %08x, F%08x L%08x .. %08x",
> +		 c->index, tag,
> +		 musb_readw(c->hw_ep->regs, MUSB_TXCSR),
> +
> +		 musb_readl(&tx->tx_head, 0),
> +		 musb_readl(&tx->tx_buf, 0),
> +		 musb_readl(&tx->tx_current, 0),
> +		 musb_readl(&tx->tx_buf_current, 0),
> +
> +		 musb_readl(&tx->tx_info, 0),
> +		 musb_readl(&tx->tx_rem_len, 0),
> +		 /* dummy/unused word 6 */
> +		 musb_readl(&tx->tx_complete, 0)
>  		);
>  }
>  
> @@ -592,11 +588,11 @@ cppi_next_tx_segment(struct musb *musb, struct cppi_channel *tx)
>  	}
>  
>  	musb_dbg(musb, "TX DMA%d, pktSz %d %s bds %d dma 0x%llx len %u",
> -			tx->index,
> -			maxpacket,
> -			rndis ? "rndis" : "transparent",
> -			n_bds,
> -			(unsigned long long)addr, length);
> +		 tx->index,
> +		 maxpacket,
> +		 rndis ? "rndis" : "transparent",
> +		 n_bds,
> +		 (unsigned long long)addr, length);
>  
>  	cppi_rndis_update(tx, 0, musb->ctrl_base, rndis);
>  
> @@ -649,8 +645,8 @@ cppi_next_tx_segment(struct musb *musb, struct cppi_channel *tx)
>  		}
>  
>  		musb_dbg(musb, "TXBD %p: nxt %08x buf %08x len %04x opt %08x",
> -				bd, bd->hw_next, bd->hw_bufp,
> -				bd->hw_off_len, bd->hw_options);
> +			 bd, bd->hw_next, bd->hw_bufp,
> +			 bd->hw_off_len, bd->hw_options);
>  
>  		/* update the last BD enqueued to the list */
>  		tx->tail = bd;
> @@ -812,18 +808,17 @@ cppi_next_rx_segment(struct musb *musb, struct cppi_channel *rx, int onepacket)
>  
>  	length = min(n_bds * maxpacket, length);
>  
> -	musb_dbg(musb, "RX DMA%d seg, maxp %d %s bds %d (cnt %d) "
> -			"dma 0x%llx len %u %u/%u",
> -			rx->index, maxpacket,
> -			onepacket
> -				? (is_rndis ? "rndis" : "onepacket")
> -				: "multipacket",
> -			n_bds,
> -			musb_readl(tibase,
> -				DAVINCI_RXCPPI_BUFCNT0_REG + (rx->index * 4))
> -					& 0xffff,
> -			(unsigned long long)addr, length,
> -			rx->channel.actual_len, rx->buf_len);
> +	musb_dbg(musb, "RX DMA%d seg, maxp %d %s bds %d (cnt %d) dma 0x%llx len %u %u/%u",
> +		 rx->index, maxpacket,
> +		 onepacket
> +		 ? (is_rndis ? "rndis" : "onepacket")
> +		 : "multipacket",
> +		 n_bds,
> +		 musb_readl(tibase,
> +			    DAVINCI_RXCPPI_BUFCNT0_REG + (rx->index * 4))
> +		 & 0xffff,
> +		 (unsigned long long)addr, length,
> +		 rx->channel.actual_len, rx->buf_len);
>  
>  	/* only queue one segment at a time, since the hardware prevents
>  	 * correct queue shutdown after unexpected short packets
> @@ -863,10 +858,13 @@ cppi_next_rx_segment(struct musb *musb, struct cppi_channel *rx, int onepacket)
>  
>  	/* we always expect at least one reusable BD! */
>  	if (!tail) {
> -		WARNING("rx dma%d -- no BDs? need %d\n", rx->index, n_bds);
> +		musb_warn(musb, "rx dma%d -- no BDs? need %d",
> +			  rx->index, n_bds);
>  		return;
> -	} else if (i < n_bds)
> -		WARNING("rx dma%d -- only %d of %d BDs\n", rx->index, i, n_bds);
> +	}
> +	if (i < n_bds)
> +		musb_warn(musb, "rx dma%d -- only %d of %d BDs",
> +			  rx->index, i, n_bds);
>  
>  	tail->next = NULL;
>  	tail->hw_next = 0;
> @@ -924,7 +922,7 @@ cppi_next_rx_segment(struct musb *musb, struct cppi_channel *rx, int onepacket)
>  			& 0xffff;
>  	if (i < (2 + n_bds)) {
>  		musb_dbg(musb, "bufcnt%d underrun - %d (for %d)",
> -					rx->index, i, n_bds);
> +			 rx->index, i, n_bds);
>  		musb_writel(tibase,
>  			DAVINCI_RXCPPI_BUFCNT0_REG + (rx->index * 4),
>  			n_bds + 2);
> @@ -960,21 +958,21 @@ static int cppi_channel_program(struct dma_channel *ch,
>  	case MUSB_DMA_STATUS_BUS_ABORT:
>  	case MUSB_DMA_STATUS_CORE_ABORT:
>  		/* fault irq handler should have handled cleanup */
> -		WARNING("%cX DMA%d not cleaned up after abort!\n",
> -				cppi_ch->transmit ? 'T' : 'R',
> -				cppi_ch->index);
> +		musb_warn(musb, "%cX DMA%d not cleaned up after abort!",
> +			  cppi_ch->transmit ? 'T' : 'R',
> +			  cppi_ch->index);
>  		/* WARN_ON(1); */
>  		break;
>  	case MUSB_DMA_STATUS_BUSY:
> -		WARNING("program active channel?  %cX DMA%d\n",
> -				cppi_ch->transmit ? 'T' : 'R',
> -				cppi_ch->index);
> +		musb_warn(musb, "program active channel?  %cX DMA%d",
> +			  cppi_ch->transmit ? 'T' : 'R',
> +			  cppi_ch->index);
>  		/* WARN_ON(1); */
>  		break;
>  	case MUSB_DMA_STATUS_UNKNOWN:
>  		musb_dbg(musb, "%cX DMA%d not allocated!",
> -				cppi_ch->transmit ? 'T' : 'R',
> -				cppi_ch->index);
> +			 cppi_ch->transmit ? 'T' : 'R',
> +			 cppi_ch->index);
>  		fallthrough;
>  	case MUSB_DMA_STATUS_FREE:
>  		break;
> @@ -1028,11 +1026,10 @@ static bool cppi_rx_scan(struct cppi *cppi, unsigned ch)
>  		if (!completed && (bd->hw_options & CPPI_OWN_SET))
>  			break;
>  
> -		musb_dbg(musb, "C/RXBD %llx: nxt %08x buf %08x "
> -			"off.len %08x opt.len %08x (%d)",
> -			(unsigned long long)bd->dma, bd->hw_next, bd->hw_bufp,
> -			bd->hw_off_len, bd->hw_options,
> -			rx->channel.actual_len);
> +		musb_dbg(musb, "C/RXBD %llx: nxt %08x buf %08x off.len %08x opt.len %08x (%d)",
> +			 (unsigned long long)bd->dma, bd->hw_next, bd->hw_bufp,
> +			 bd->hw_off_len, bd->hw_options,
> +			 rx->channel.actual_len);
>  
>  		/* actual packet received length */
>  		if ((bd->hw_options & CPPI_SOP_SET) && !completed)
> @@ -1051,8 +1048,7 @@ static bool cppi_rx_scan(struct cppi *cppi, unsigned ch)
>  			 */
>  			completed = true;
>  			musb_dbg(musb, "rx short %d/%d (%d)",
> -					len, bd->buflen,
> -					rx->channel.actual_len);
> +				 len, bd->buflen, rx->channel.actual_len);
>  		}
>  
>  		/* If we got here, we expect to ack at least one BD; meanwhile
> @@ -1101,14 +1097,14 @@ static bool cppi_rx_scan(struct cppi *cppi, unsigned ch)
>  		csr = musb_readw(regs, MUSB_RXCSR);
>  		if (csr & MUSB_RXCSR_DMAENAB) {
>  			musb_dbg(musb, "list%d %p/%p, last %llx%s, csr %04x",
> -				rx->index,
> -				rx->head, rx->tail,
> -				rx->last_processed
> -					? (unsigned long long)
> -						rx->last_processed->dma
> -					: 0,
> -				completed ? ", completed" : "",
> -				csr);
> +				 rx->index,
> +				 rx->head, rx->tail,
> +				 rx->last_processed
> +				 ? (unsigned long long)
> +				 rx->last_processed->dma
> +				 : 0,
> +				 completed ? ", completed" : "",
> +				 csr);
>  			cppi_dump_rxq(4, "/what?", rx);
>  		}
>  	}
> @@ -1207,8 +1203,8 @@ irqreturn_t cppi_interrupt(int irq, void *dev_id)
>  				break;
>  
>  			musb_dbg(musb, "C/TXBD %p n %x b %x off %x opt %x",
> -					bd, bd->hw_next, bd->hw_bufp,
> -					bd->hw_off_len, bd->hw_options);
> +				 bd, bd->hw_next, bd->hw_bufp,
> +				 bd->hw_off_len, bd->hw_options);
>  
>  			len = bd->hw_off_len & CPPI_BUFFER_LEN_MASK;
>  			tx_ch->channel.actual_len += len;
> diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
> index 1c023c0091c4..2bc2924af5d9 100644
> --- a/drivers/usb/musb/da8xx.c
> +++ b/drivers/usb/musb/da8xx.c
> @@ -276,7 +276,7 @@ static irqreturn_t da8xx_musb_interrupt(int irq, void *hci)
>  			musb->int_usb &= ~MUSB_INTR_VBUSERROR;
>  			musb->xceiv->otg->state = OTG_STATE_A_WAIT_VFALL;
>  			mod_timer(&musb->dev_timer, jiffies + POLL_SECONDS * HZ);
> -			WARNING("VBUS error workaround (delay coming)\n");
> +			musb_warn(musb, "VBUS error workaround (delay coming)");
>  		} else if (drvvbus) {
>  			MUSB_HST_MODE(musb);
>  			musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
> diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
> index 704435526394..625cd2e07fa6 100644
> --- a/drivers/usb/musb/davinci.c
> +++ b/drivers/usb/musb/davinci.c
> @@ -92,8 +92,7 @@ static void davinci_musb_enable(struct musb *musb)
>  	musb_writel(musb->ctrl_base, DAVINCI_USB_INT_MASK_SET_REG, tmp);
>  
>  	if (is_dma_capable() && !dma_off)
> -		printk(KERN_WARNING "%s %s: dma not reactivated\n",
> -				__FILE__, __func__);
> +		musb_warn(musb, "dma not reactivated");
>  	else
>  		dma_off = 0;
>  
> @@ -119,7 +118,7 @@ static void davinci_musb_disable(struct musb *musb)
>  	musb_writel(musb->ctrl_base, DAVINCI_USB_EOI_REG, 0);
>  
>  	if (is_dma_capable() && !dma_off)
> -		WARNING("dma still active\n");
> +		musb_warn(musb, "dma still active");
>  }
>  
>  
> @@ -308,7 +307,7 @@ static irqreturn_t davinci_musb_interrupt(int irq, void *__hci)
>  			musb->int_usb &= ~MUSB_INTR_VBUSERROR;
>  			musb->xceiv->otg->state = OTG_STATE_A_WAIT_VFALL;
>  			mod_timer(&musb->dev_timer, jiffies + POLL_SECONDS * HZ);
> -			WARNING("VBUS error workaround (delay coming)\n");
> +			musb_warn(musb, "VBUS error workaround (delay coming)");
>  		} else if (drvvbus) {
>  			MUSB_HST_MODE(musb);
>  			musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index 849e0b770130..c6961184afff 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -600,8 +600,7 @@ static void musb_otg_timer_func(struct timer_list *t)
>  	spin_lock_irqsave(&musb->lock, flags);
>  	switch (musb->xceiv->otg->state) {
>  	case OTG_STATE_B_WAIT_ACON:
> -		musb_dbg(musb,
> -			"HNP: b_wait_acon timeout; back to b_peripheral");
> +		musb_dbg(musb, "HNP: b_wait_acon timeout; back to b_peripheral");
>  		musb_g_disconnect(musb);
>  		musb->xceiv->otg->state = OTG_STATE_B_PERIPHERAL;
>  		musb->is_active = 0;
> @@ -609,13 +608,13 @@ static void musb_otg_timer_func(struct timer_list *t)
>  	case OTG_STATE_A_SUSPEND:
>  	case OTG_STATE_A_WAIT_BCON:
>  		musb_dbg(musb, "HNP: %s timeout",
> -			usb_otg_state_string(musb->xceiv->otg->state));
> +			 usb_otg_state_string(musb->xceiv->otg->state));
>  		musb_platform_set_vbus(musb, 0);
>  		musb->xceiv->otg->state = OTG_STATE_A_WAIT_VFALL;
>  		break;
>  	default:
>  		musb_dbg(musb, "HNP: Unhandled mode %s",
> -			usb_otg_state_string(musb->xceiv->otg->state));
> +			 usb_otg_state_string(musb->xceiv->otg->state));
>  	}
>  	spin_unlock_irqrestore(&musb->lock, flags);
>  }
> @@ -630,13 +629,13 @@ void musb_hnp_stop(struct musb *musb)
>  	u8	reg;
>  
>  	musb_dbg(musb, "HNP: stop from %s",
> -			usb_otg_state_string(musb->xceiv->otg->state));
> +		 usb_otg_state_string(musb->xceiv->otg->state));
>  
>  	switch (musb->xceiv->otg->state) {
>  	case OTG_STATE_A_PERIPHERAL:
>  		musb_g_disconnect(musb);
>  		musb_dbg(musb, "HNP: back to %s",
> -			usb_otg_state_string(musb->xceiv->otg->state));
> +			 usb_otg_state_string(musb->xceiv->otg->state));
>  		break;
>  	case OTG_STATE_B_HOST:
>  		musb_dbg(musb, "HNP: Disabling HR");
> @@ -651,7 +650,7 @@ void musb_hnp_stop(struct musb *musb)
>  		break;
>  	default:
>  		musb_dbg(musb, "HNP: Stopping in unknown state %s",
> -			usb_otg_state_string(musb->xceiv->otg->state));
> +			 usb_otg_state_string(musb->xceiv->otg->state));
>  	}
>  
>  	/*
> @@ -667,7 +666,7 @@ static void musb_recover_from_babble(struct musb *musb);
>  static void musb_handle_intr_resume(struct musb *musb, u8 devctl)
>  {
>  	musb_dbg(musb, "RESUME (%s)",
> -			usb_otg_state_string(musb->xceiv->otg->state));
> +		 usb_otg_state_string(musb->xceiv->otg->state));
>  
>  	if (devctl & MUSB_DEVCTL_HM) {
>  		switch (musb->xceiv->otg->state) {
> @@ -690,9 +689,8 @@ static void musb_handle_intr_resume(struct musb *musb, u8 devctl)
>  			MUSB_DEV_MODE(musb);
>  			break;
>  		default:
> -			WARNING("bogus %s RESUME (%s)\n",
> -				"host",
> -				usb_otg_state_string(musb->xceiv->otg->state));
> +			musb_warn(musb, "bogus host RESUME (%s)",
> +				  usb_otg_state_string(musb->xceiv->otg->state));
>  		}
>  	} else {
>  		switch (musb->xceiv->otg->state) {
> @@ -719,9 +717,8 @@ static void musb_handle_intr_resume(struct musb *musb, u8 devctl)
>  			musb->int_usb &= ~MUSB_INTR_SUSPEND;
>  			break;
>  		default:
> -			WARNING("bogus %s RESUME (%s)\n",
> -				"peripheral",
> -				usb_otg_state_string(musb->xceiv->otg->state));
> +			musb_warn(musb, "bogus peripheral RESUME (%s)",
> +				  usb_otg_state_string(musb->xceiv->otg->state));
>  		}
>  	}
>  }
> @@ -738,7 +735,7 @@ static irqreturn_t musb_handle_intr_sessreq(struct musb *musb, u8 devctl)
>  	}
>  
>  	musb_dbg(musb, "SESSION_REQUEST (%s)",
> -		usb_otg_state_string(musb->xceiv->otg->state));
> +		 usb_otg_state_string(musb->xceiv->otg->state));
>  
>  	/* IRQ arrives from ID pin sense or (later, if VBUS power
>  	 * is removed) SRP.  responses are time critical:
> @@ -830,7 +827,7 @@ static void musb_handle_intr_vbuserr(struct musb *musb, u8 devctl)
>  static void musb_handle_intr_suspend(struct musb *musb, u8 devctl)
>  {
>  	musb_dbg(musb, "SUSPEND (%s) devctl %02x",
> -		usb_otg_state_string(musb->xceiv->otg->state), devctl);
> +		 usb_otg_state_string(musb->xceiv->otg->state), devctl);
>  
>  	switch (musb->xceiv->otg->state) {
>  	case OTG_STATE_A_PERIPHERAL:
> @@ -938,14 +935,14 @@ static void musb_handle_intr_connect(struct musb *musb, u8 devctl, u8 int_usb)
>  	musb_host_poke_root_hub(musb);
>  
>  	musb_dbg(musb, "CONNECT (%s) devctl %02x",
> -			usb_otg_state_string(musb->xceiv->otg->state), devctl);
> +		 usb_otg_state_string(musb->xceiv->otg->state), devctl);
>  }
>  
>  static void musb_handle_intr_disconnect(struct musb *musb, u8 devctl)
>  {
>  	musb_dbg(musb, "DISCONNECT (%s) as %s, devctl %02x",
> -			usb_otg_state_string(musb->xceiv->otg->state),
> -			MUSB_MODE(musb), devctl);
> +		 usb_otg_state_string(musb->xceiv->otg->state),
> +		 MUSB_MODE(musb), devctl);
>  
>  	switch (musb->xceiv->otg->state) {
>  	case OTG_STATE_A_HOST:
> @@ -979,8 +976,8 @@ static void musb_handle_intr_disconnect(struct musb *musb, u8 devctl)
>  		musb_g_disconnect(musb);
>  		break;
>  	default:
> -		WARNING("unhandled DISCONNECT transition (%s)\n",
> -			usb_otg_state_string(musb->xceiv->otg->state));
> +		musb_warn(musb, "unhandled DISCONNECT transition (%s)",
> +			  usb_otg_state_string(musb->xceiv->otg->state));
>  		break;
>  	}
>  }
> @@ -1004,7 +1001,7 @@ static void musb_handle_intr_reset(struct musb *musb)
>  		musb_recover_from_babble(musb);
>  	} else {
>  		musb_dbg(musb, "BUS RESET as %s",
> -			usb_otg_state_string(musb->xceiv->otg->state));
> +			 usb_otg_state_string(musb->xceiv->otg->state));
>  		switch (musb->xceiv->otg->state) {
>  		case OTG_STATE_A_SUSPEND:
>  			musb_g_reset(musb);
> @@ -1012,8 +1009,8 @@ static void musb_handle_intr_reset(struct musb *musb)
>  		case OTG_STATE_A_WAIT_BCON:	/* OPT TD.4.7-900ms */
>  			/* never use invalid T(a_wait_bcon) */
>  			musb_dbg(musb, "HNP: in %s, %d msec timeout",
> -				usb_otg_state_string(musb->xceiv->otg->state),
> -				TA_WAIT_BCON(musb));
> +				 usb_otg_state_string(musb->xceiv->otg->state),
> +				 TA_WAIT_BCON(musb));
>  			mod_timer(&musb->otg_timer, jiffies
>  				+ msecs_to_jiffies(TA_WAIT_BCON(musb)));
>  			break;
> @@ -1023,7 +1020,7 @@ static void musb_handle_intr_reset(struct musb *musb)
>  			break;
>  		case OTG_STATE_B_WAIT_ACON:
>  			musb_dbg(musb, "HNP: RESET (%s), to b_peripheral",
> -				usb_otg_state_string(musb->xceiv->otg->state));
> +				 usb_otg_state_string(musb->xceiv->otg->state));
>  			musb->xceiv->otg->state = OTG_STATE_B_PERIPHERAL;
>  			musb_g_reset(musb);
>  			break;
> @@ -1035,7 +1032,7 @@ static void musb_handle_intr_reset(struct musb *musb)
>  			break;
>  		default:
>  			musb_dbg(musb, "Unhandled BUS RESET as %s",
> -				usb_otg_state_string(musb->xceiv->otg->state));
> +				 usb_otg_state_string(musb->xceiv->otg->state));
>  		}
>  	}
>  }
> @@ -1692,19 +1689,19 @@ static int musb_core_init(u16 musb_type, struct musb *musb)
>  
>  		if (hw_ep->max_packet_sz_tx) {
>  			musb_dbg(musb, "%s: hw_ep %d%s, %smax %d",
> -				musb_driver_name, i,
> -				hw_ep->is_shared_fifo ? "shared" : "tx",
> -				hw_ep->tx_double_buffered
> -					? "doublebuffer, " : "",
> -				hw_ep->max_packet_sz_tx);
> +				 musb_driver_name, i,
> +				 hw_ep->is_shared_fifo ? "shared" : "tx",
> +				 hw_ep->tx_double_buffered
> +				 ? "doublebuffer, " : "",
> +				 hw_ep->max_packet_sz_tx);
>  		}
>  		if (hw_ep->max_packet_sz_rx && !hw_ep->is_shared_fifo) {
>  			musb_dbg(musb, "%s: hw_ep %d%s, %smax %d",
> -				musb_driver_name, i,
> -				"rx",
> -				hw_ep->rx_double_buffered
> -					? "doublebuffer, " : "",
> -				hw_ep->max_packet_sz_rx);
> +				 musb_driver_name, i,
> +				 "rx",
> +				 hw_ep->rx_double_buffered
> +				 ? "doublebuffer, " : "",
> +				 hw_ep->max_packet_sz_rx);
>  		}
>  		if (!(hw_ep->max_packet_sz_tx || hw_ep->max_packet_sz_rx))
>  			musb_dbg(musb, "hw_ep %d not configured", i);
> @@ -2004,7 +2001,7 @@ static void musb_pm_runtime_check_session(struct musb *musb)
>  		MUSB_DEVCTL_HR;
>  	switch (devctl & ~s) {
>  	case MUSB_QUIRK_B_DISCONNECT_99:
> -		musb_dbg(musb, "Poll devctl in case of suspend after disconnect\n");
> +		musb_dbg(musb, "Poll devctl in case of suspend after disconnect");
>  		schedule_delayed_work(&musb->irq_work,
>  				      msecs_to_jiffies(1000));
>  		break;
> @@ -2048,8 +2045,7 @@ static void musb_pm_runtime_check_session(struct musb *musb)
>  		musb_dbg(musb, "Block PM on active session: %02x", devctl);
>  		error = pm_runtime_get_sync(musb->controller);
>  		if (error < 0)
> -			dev_err(musb->controller, "Could not enable: %i\n",
> -				error);
> +			musb_err(musb, "Could not enable: %i", error);
>  		musb->quirk_retries = 3;
>  	} else {
>  		musb_dbg(musb, "Allow PM with no session: %02x", devctl);
> diff --git a/drivers/usb/musb/musb_cppi41.c b/drivers/usb/musb/musb_cppi41.c
> index 7fbb8a307145..2e8323fd4613 100644
> --- a/drivers/usb/musb/musb_cppi41.c
> +++ b/drivers/usb/musb/musb_cppi41.c
> @@ -91,7 +91,7 @@ static void update_rx_toggle(struct cppi41_dma_channel *cppi41_channel)
>  	if (!toggle && toggle == cppi41_channel->usb_toggle) {
>  		csr |= MUSB_RXCSR_H_DATATOGGLE | MUSB_RXCSR_H_WR_DATATOGGLE;
>  		musb_writew(cppi41_channel->hw_ep->regs, MUSB_RXCSR, csr);
> -		musb_dbg(musb, "Restoring DATA1 toggle.");
> +		musb_dbg(musb, "Restoring DATA1 toggle");
>  	}
>  
>  	cppi41_channel->usb_toggle = toggle;
> diff --git a/drivers/usb/musb/musb_debug.h b/drivers/usb/musb/musb_debug.h
> index e5b3506c7b3f..8c96428dade5 100644
> --- a/drivers/usb/musb/musb_debug.h
> +++ b/drivers/usb/musb/musb_debug.h
> @@ -10,12 +10,14 @@
>  #ifndef __MUSB_LINUX_DEBUG_H__
>  #define __MUSB_LINUX_DEBUG_H__
>  
> -#define yprintk(facility, format, args...) \
> -	do { printk(facility "%s %d: " format , \
> -	__func__, __LINE__ , ## args); } while (0)
> -#define WARNING(fmt, args...) yprintk(KERN_WARNING, fmt, ## args)
> -#define INFO(fmt, args...) yprintk(KERN_INFO, fmt, ## args)
> -#define ERR(fmt, args...) yprintk(KERN_ERR, fmt, ## args)
> +#define musb_err(musb, fmt, ...)					\
> +	dev_err((musb)->controller, fmt "\n", ##__VA_ARGS__)
> +#define musb_warn(musb, fmt, ...)					\
> +	dev_warn((musb)->controller, fmt "\n", ##__VA_ARGS__)
> +#define musb_notice(musb, fmt, ...)					\
> +	dev_notice((musb)->controller, fmt "\n", ##__VA_ARGS__)
> +#define musb_info(musb, fmt, ...)					\
> +	dev_info((musb)->controller, fmt "\n", ##__VA_ARGS__)
>  
>  void musb_dbg(struct musb *musb, const char *fmt, ...);
>  
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index 5892f3ce0cdc..a045cd85197b 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -366,7 +366,7 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
>  			musb->int_usb &= ~MUSB_INTR_VBUSERROR;
>  			musb->xceiv->otg->state = OTG_STATE_A_WAIT_VFALL;
>  			dsps_mod_timer_optional(glue);
> -			WARNING("VBUS error workaround (delay coming)\n");
> +			musb_warn(musb, "VBUS error workaround (delay coming)");
>  		} else if (drvvbus) {
>  			MUSB_HST_MODE(musb);
>  			musb->xceiv->otg->state = OTG_STATE_A_WAIT_VRISE;
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index f62ffaede1ab..f5b76e689fca 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -234,7 +234,7 @@ static void txstate(struct musb *musb, struct musb_request *req)
>  	/* Check if EP is disabled */
>  	if (!musb_ep->desc) {
>  		musb_dbg(musb, "ep:%s disabled - ignore request",
> -						musb_ep->end_point.name);
> +			 musb_ep->end_point.name);
>  		return;
>  	}
>  
> @@ -252,20 +252,19 @@ static void txstate(struct musb *musb, struct musb_request *req)
>  			(int)(request->length - request->actual));
>  
>  	if (csr & MUSB_TXCSR_TXPKTRDY) {
> -		musb_dbg(musb, "%s old packet still ready , txcsr %03x",
> -				musb_ep->end_point.name, csr);
> +		musb_dbg(musb, "%s old packet still ready, txcsr %03x",
> +			 musb_ep->end_point.name, csr);
>  		return;
>  	}
>  
>  	if (csr & MUSB_TXCSR_P_SENDSTALL) {
>  		musb_dbg(musb, "%s stalling, txcsr %03x",
> -				musb_ep->end_point.name, csr);
> +			 musb_ep->end_point.name, csr);
>  		return;
>  	}
>  
>  	musb_dbg(musb, "hw_ep%d, maxpacket %d, fifo count %d, txcsr %03x",
> -			epnum, musb_ep->packet_sz, fifo_count,
> -			csr);
> +		 epnum, musb_ep->packet_sz, fifo_count, csr);
>  
>  #ifndef	CONFIG_MUSB_PIO_ONLY
>  	if (is_buffer_mapped(req)) {
> @@ -392,11 +391,11 @@ static void txstate(struct musb *musb, struct musb_request *req)
>  
>  	/* host may already have the data when this message shows... */
>  	musb_dbg(musb, "%s TX/IN %s len %d/%d, txcsr %04x, fifo %d/%d",
> -			musb_ep->end_point.name, use_dma ? "dma" : "pio",
> -			request->actual, request->length,
> -			musb_readw(epio, MUSB_TXCSR),
> -			fifo_count,
> -			musb_readw(epio, MUSB_TXMAXP));
> +		 musb_ep->end_point.name, use_dma ? "dma" : "pio",
> +		 request->actual, request->length,
> +		 musb_readw(epio, MUSB_TXCSR),
> +		 fifo_count,
> +		 musb_readw(epio, MUSB_TXMAXP));
>  }
>  
>  /*
> @@ -464,7 +463,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
>  			csr = musb_readw(epio, MUSB_TXCSR);
>  			request->actual += musb_ep->dma->actual_len;
>  			musb_dbg(musb, "TXCSR%d %04x, DMA off, len %zu, req %p",
> -				epnum, csr, musb_ep->dma->actual_len, request);
> +				 epnum, csr, musb_ep->dma->actual_len, request);
>  		}
>  
>  		/*
> @@ -501,7 +500,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
>  			req = musb_ep->desc ? next_request(musb_ep) : NULL;
>  			if (!req) {
>  				musb_dbg(musb, "%s idle now",
> -					musb_ep->end_point.name);
> +					 musb_ep->end_point.name);
>  				return;
>  			}
>  		}
> @@ -537,7 +536,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
>  	/* Check if EP is disabled */
>  	if (!musb_ep->desc) {
>  		musb_dbg(musb, "ep:%s disabled - ignore request",
> -						musb_ep->end_point.name);
> +			 musb_ep->end_point.name);
>  		return;
>  	}
>  
> @@ -549,7 +548,7 @@ static void rxstate(struct musb *musb, struct musb_request *req)
>  
>  	if (csr & MUSB_RXCSR_P_SENDSTALL) {
>  		musb_dbg(musb, "%s stalling, RXCSR %04x",
> -		    musb_ep->end_point.name, csr);
> +			 musb_ep->end_point.name, csr);
>  		return;
>  	}
>  
> @@ -724,9 +723,9 @@ static void rxstate(struct musb *musb, struct musb_request *req)
>  
>  			len = request->length - request->actual;
>  			musb_dbg(musb, "%s OUT/RX pio fifo %d/%d, maxpacket %d",
> -					musb_ep->end_point.name,
> -					fifo_count, len,
> -					musb_ep->packet_sz);
> +				 musb_ep->end_point.name,
> +				 fifo_count, len,
> +				 musb_ep->packet_sz);
>  
>  			fifo_count = min_t(unsigned, len, fifo_count);
>  
> @@ -812,8 +811,8 @@ void musb_g_rx(struct musb *musb, u8 epnum)
>  	csr = musb_readw(epio, MUSB_RXCSR);
>  	dma = is_dma_capable() ? musb_ep->dma : NULL;
>  
> -	musb_dbg(musb, "<== %s, rxcsr %04x%s %p", musb_ep->end_point.name,
> -			csr, dma ? " (dma)" : "", request);
> +	musb_dbg(musb, "<== %s, rxcsr %04x%s %p",
> +		 musb_ep->end_point.name, csr, dma ? " (dma)" : "", request);
>  
>  	if (csr & MUSB_RXCSR_P_SENTSTALL) {
>  		csr |= MUSB_RXCSR_P_WZC_BITS;
> @@ -839,7 +838,7 @@ void musb_g_rx(struct musb *musb, u8 epnum)
>  	if (dma_channel_status(dma) == MUSB_DMA_STATUS_BUSY) {
>  		/* "should not happen"; likely RXPKTRDY pending for DMA */
>  		musb_dbg(musb, "%s busy, csr %04x",
> -			musb_ep->end_point.name, csr);
> +			 musb_ep->end_point.name, csr);
>  		return;
>  	}
>  
> @@ -1232,8 +1231,8 @@ static int musb_gadget_queue(struct usb_ep *ep, struct usb_request *req,
>  
>  	/* don't queue if the ep is down */
>  	if (!musb_ep->desc) {
> -		musb_dbg(musb, "req %p queued to %s while ep %s",
> -				req, ep->name, "disabled");
> +		musb_dbg(musb, "req %p queued to %s while ep disabled",
> +			 req, ep->name);
>  		status = -ESHUTDOWN;
>  		unmap_dma_buffer(request, musb);
>  		goto unlock;
> @@ -1349,7 +1348,7 @@ static int musb_gadget_set_halt(struct usb_ep *ep, int value)
>  	if (value) {
>  		if (request) {
>  			musb_dbg(musb, "request in progress, cannot halt %s",
> -			    ep->name);
> +				 ep->name);
>  			status = -EAGAIN;
>  			goto done;
>  		}
> @@ -1358,7 +1357,7 @@ static int musb_gadget_set_halt(struct usb_ep *ep, int value)
>  			csr = musb_readw(epio, MUSB_TXCSR);
>  			if (csr & MUSB_TXCSR_FIFONOTEMPTY) {
>  				musb_dbg(musb, "FIFO busy, cannot halt %s",
> -						ep->name);
> +					 ep->name);
>  				status = -EAGAIN;
>  				goto done;
>  			}
> @@ -1559,7 +1558,7 @@ static int musb_gadget_wakeup(struct usb_gadget *gadget)
>  		goto done;
>  	default:
>  		musb_dbg(musb, "Unhandled wake: %s",
> -			usb_otg_state_string(musb->xceiv->otg->state));
> +			 usb_otg_state_string(musb->xceiv->otg->state));
>  		goto done;
>  	}
>  
> @@ -1600,8 +1599,7 @@ static void musb_pullup(struct musb *musb, int is_on)
>  
>  	/* FIXME if on, HdrcStart; if off, HdrcStop */
>  
> -	musb_dbg(musb, "gadget D+ pullup %s",
> -		is_on ? "on" : "off");
> +	musb_dbg(musb, "gadget D+ pullup %s", is_on ? "on" : "off");
>  	musb_writeb(musb->mregs, MUSB_POWER, power);
>  }
>  
> @@ -1936,8 +1934,8 @@ void musb_g_resume(struct musb *musb)
>  		}
>  		break;
>  	default:
> -		WARNING("unhandled RESUME transition (%s)\n",
> -				usb_otg_state_string(musb->xceiv->otg->state));
> +		musb_warn(musb, "unhandled RESUME transition (%s)",
> +			  usb_otg_state_string(musb->xceiv->otg->state));
>  	}
>  }
>  
> @@ -1966,8 +1964,8 @@ void musb_g_suspend(struct musb *musb)
>  		/* REVISIT if B_HOST, clear DEVCTL.HOSTREQ;
>  		 * A_PERIPHERAL may need care too
>  		 */
> -		WARNING("unhandled SUSPEND transition (%s)",
> -				usb_otg_state_string(musb->xceiv->otg->state));
> +		musb_warn(musb, "unhandled SUSPEND transition (%s)",
> +			  usb_otg_state_string(musb->xceiv->otg->state));
>  	}
>  }
>  
> @@ -2001,7 +1999,7 @@ void musb_g_disconnect(struct musb *musb)
>  	switch (musb->xceiv->otg->state) {
>  	default:
>  		musb_dbg(musb, "Unhandled disconnect %s, setting a_idle",
> -			usb_otg_state_string(musb->xceiv->otg->state));
> +			 usb_otg_state_string(musb->xceiv->otg->state));
>  		musb->xceiv->otg->state = OTG_STATE_A_IDLE;
>  		MUSB_HST_MODE(musb);
>  		break;
> @@ -2031,12 +2029,12 @@ __acquires(musb->lock)
>  	u8		power;
>  
>  	musb_dbg(musb, "<== %s driver '%s'",
> -			(devctl & MUSB_DEVCTL_BDEVICE)
> -				? "B-Device" : "A-Device",
> -			musb->gadget_driver
> -				? musb->gadget_driver->driver.name
> -				: NULL
> -			);
> +		 (devctl & MUSB_DEVCTL_BDEVICE)
> +		 ? "B-Device" : "A-Device",
> +		 musb->gadget_driver
> +		 ? musb->gadget_driver->driver.name
> +		 : NULL
> +		);
>  
>  	/* report reset, if we didn't already (flushing EP state) */
>  	if (musb->gadget_driver && musb->g.speed != USB_SPEED_UNKNOWN) {
> diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
> index 6d7336727388..130db182bf09 100644
> --- a/drivers/usb/musb/musb_gadget_ep0.c
> +++ b/drivers/usb/musb/musb_gadget_ep0.c
> @@ -583,11 +583,11 @@ musb_read_setup(struct musb *musb, struct usb_ctrlrequest *req)
>  	 * order, but now USB packets always stay in USB byte order.
>  	 */
>  	musb_dbg(musb, "SETUP req%02x.%02x v%04x i%04x l%d",
> -		req->bRequestType,
> -		req->bRequest,
> -		le16_to_cpu(req->wValue),
> -		le16_to_cpu(req->wIndex),
> -		le16_to_cpu(req->wLength));
> +		 req->bRequestType,
> +		 req->bRequest,
> +		 le16_to_cpu(req->wValue),
> +		 le16_to_cpu(req->wIndex),
> +		 le16_to_cpu(req->wLength));
>  
>  	/* clean up any leftover transfers */
>  	r = next_ep0_request(musb);
> @@ -651,7 +651,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
>  	len = musb_readb(regs, MUSB_COUNT0);
>  
>  	musb_dbg(musb, "csr %04x, count %d, ep0stage %s",
> -			csr, len, decode_ep0stage(musb->ep0_state));
> +		 csr, len, decode_ep0stage(musb->ep0_state));
>  
>  	if (csr & MUSB_CSR0_P_DATAEND) {
>  		/*
> @@ -683,8 +683,8 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
>  			musb->ep0_state = MUSB_EP0_STAGE_STATUSIN;
>  			break;
>  		default:
> -			ERR("SetupEnd came in a wrong ep0stage %s\n",
> -			    decode_ep0stage(musb->ep0_state));
> +			musb_err(musb, "SetupEnd came in a wrong ep0stage %s",
> +				 decode_ep0stage(musb->ep0_state));
>  		}
>  		csr = musb_readw(regs, MUSB_CSR0);
>  		/* NOTE:  request may need completion */
> @@ -776,7 +776,8 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
>  			int			handled = 0;
>  
>  			if (len != 8) {
> -				ERR("SETUP packet len %d != 8 ?\n", len);
> +				musb_err(musb, "SETUP packet len %d != 8 ?",
> +					 len);
>  				break;
>  			}
>  			musb_read_setup(musb, &setup);
> @@ -786,9 +787,7 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
>  			if (unlikely(musb->g.speed == USB_SPEED_UNKNOWN)) {
>  				u8	power;
>  
> -				printk(KERN_NOTICE "%s: peripheral reset "
> -						"irq lost!\n",
> -						musb_driver_name);
> +				musb_notice(musb, "peripheral reset irq lost!");
>  				power = musb_readb(mbase, MUSB_POWER);
>  				musb->g.speed = (power & MUSB_POWER_HSMODE)
>  					? USB_SPEED_HIGH : USB_SPEED_FULL;
> @@ -840,8 +839,8 @@ irqreturn_t musb_g_ep0_irq(struct musb *musb)
>  			}
>  
>  			musb_dbg(musb, "handled %d, csr %04x, ep0stage %s",
> -				handled, csr,
> -				decode_ep0stage(musb->ep0_state));
> +				 handled, csr,
> +				 decode_ep0stage(musb->ep0_state));
>  
>  			/* unless we need to delegate this to the gadget
>  			 * driver, we know how to wrap this up:  csr0 has
> @@ -937,7 +936,7 @@ musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t gfp_flags)
>  		break;
>  	default:
>  		musb_dbg(musb, "ep0 request queued in state %d",
> -				musb->ep0_state);
> +			 musb->ep0_state);
>  		status = -EINVAL;
>  		goto cleanup;
>  	}
> @@ -946,8 +945,8 @@ musb_g_ep0_queue(struct usb_ep *e, struct usb_request *r, gfp_t gfp_flags)
>  	list_add_tail(&req->list, &ep->req_list);
>  
>  	musb_dbg(musb, "queue to %s (%s), length=%d",
> -			ep->name, ep->is_in ? "IN/TX" : "OUT/RX",
> -			req->request.length);
> +		 ep->name, ep->is_in ? "IN/TX" : "OUT/RX",
> +		 req->request.length);
>  
>  	musb_ep_select(musb->mregs, 0);
>  
> diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
> index 30c5e7de0761..abc2af31dc4e 100644
> --- a/drivers/usb/musb/musb_host.c
> +++ b/drivers/usb/musb/musb_host.c
> @@ -263,8 +263,8 @@ musb_start_urb(struct musb *musb, int is_in, struct musb_qh *qh)
>  		break;
>  	default:
>  start:
> -		musb_dbg(musb, "Start TX%d %s", epnum,
> -			hw_ep->tx_channel ? "dma" : "pio");
> +		musb_dbg(musb, "Start TX%d %s",
> +			 epnum, hw_ep->tx_channel ? "dma" : "pio");
>  
>  		if (!hw_ep->tx_channel)
>  			musb_h_tx_start(hw_ep);
> @@ -376,7 +376,7 @@ static void musb_advance_schedule(struct musb *musb, struct urb *urb,
>  
>  	if (qh != NULL && qh->is_ready) {
>  		musb_dbg(musb, "... next ep%d %cX urb %p",
> -		    hw_ep->epnum, is_in ? 'R' : 'T', next_urb(qh));
> +			 hw_ep->epnum, is_in ? 'R' : 'T', next_urb(qh));
>  		musb_start_urb(musb, is_in, qh);
>  	}
>  }
> @@ -420,9 +420,10 @@ musb_host_packet_rx(struct musb *musb, struct urb *urb, u8 epnum, u8 iso_err)
>  
>  	/* musb_ep_select(mbase, epnum); */
>  	rx_count = musb_readw(epio, MUSB_RXCOUNT);
> -	musb_dbg(musb, "RX%d count %d, buffer %p len %d/%d", epnum, rx_count,
> -			urb->transfer_buffer, qh->offset,
> -			urb->transfer_buffer_length);
> +	musb_dbg(musb, "RX%d count %d, buffer %p len %d/%d",
> +		 epnum, rx_count,
> +		 urb->transfer_buffer, qh->offset,
> +		 urb->transfer_buffer_length);
>  
>  	/* unload FIFO */
>  	if (usb_pipeisoc(pipe)) {
> @@ -537,8 +538,8 @@ musb_rx_reinit(struct musb *musb, struct musb_qh *qh, u8 epnum)
>  	}
>  	csr = musb_readw(ep->regs, MUSB_RXCSR);
>  	if (csr & MUSB_RXCSR_RXPKTRDY)
> -		WARNING("rx%d, packet/%d ready?\n", ep->epnum,
> -			musb_readw(ep->regs, MUSB_RXCOUNT));
> +		musb_warn(musb, "rx%d, packet/%d ready?",
> +			  ep->epnum, musb_readw(ep->regs, MUSB_RXCOUNT));
>  
>  	musb_h_flush_rxfifo(ep, MUSB_RXCSR_CLRDATATOG);
>  
> @@ -681,13 +682,12 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
>  	u8			use_dma = 1;
>  	u16			csr;
>  
> -	musb_dbg(musb, "%s hw%d urb %p spd%d dev%d ep%d%s "
> -				"h_addr%02x h_port%02x bytes %d",
> -			is_out ? "-->" : "<--",
> -			epnum, urb, urb->dev->speed,
> -			qh->addr_reg, qh->epnum, is_out ? "out" : "in",
> -			qh->h_addr_reg, qh->h_port_reg,
> -			len);
> +	musb_dbg(musb, "%s hw%d urb %p spd%d dev%d ep%d%s h_addr%02x h_port%02x bytes %d",
> +		 is_out ? "-->" : "<--",
> +		 epnum, urb, urb->dev->speed,
> +		 qh->addr_reg, qh->epnum, is_out ? "out" : "in",
> +		 qh->h_addr_reg, qh->h_port_reg,
> +		 len);
>  
>  	musb_ep_select(mbase, epnum);
>  
> @@ -852,8 +852,8 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
>  			if (csr & (MUSB_RXCSR_RXPKTRDY
>  					| MUSB_RXCSR_DMAENAB
>  					| MUSB_RXCSR_H_REQPKT))
> -				ERR("broken !rx_reinit, ep%d csr %04x\n",
> -						hw_ep->epnum, csr);
> +				musb_err(musb, "broken !rx_reinit, ep%d csr %04x",
> +					 hw_ep->epnum, csr);
>  
>  			/* scrub any stale state, leaving toggle alone */
>  			csr &= MUSB_RXCSR_DISNYET;
> @@ -1028,9 +1028,9 @@ static bool musb_h_ep0_continue(struct musb *musb, u16 len, struct urb *urb)
>  			fifo_dest = (u8 *) (urb->transfer_buffer
>  					+ urb->actual_length);
>  			musb_dbg(musb, "Sending %d byte%s to ep0 fifo %p",
> -					fifo_count,
> -					(fifo_count == 1) ? "" : "s",
> -					fifo_dest);
> +				 fifo_count,
> +				 (fifo_count == 1) ? "" : "s",
> +				 fifo_dest);
>  			musb_write_fifo(hw_ep, fifo_count, fifo_dest);
>  
>  			urb->actual_length += fifo_count;
> @@ -1038,7 +1038,7 @@ static bool musb_h_ep0_continue(struct musb *musb, u16 len, struct urb *urb)
>  		}
>  		break;
>  	default:
> -		ERR("bogus ep0 stage %d\n", musb->ep0_stage);
> +		musb_err(musb, "bogus ep0 stage %d", musb->ep0_stage);
>  		break;
>  	}
>  
> @@ -1073,7 +1073,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
>  			: 0;
>  
>  	musb_dbg(musb, "<== csr0 %04x, qh %p, count %d, urb %p, stage %d",
> -		csr, qh, len, urb, musb->ep0_stage);
> +		 csr, qh, len, urb, musb->ep0_stage);
>  
>  	/* if we just did status stage, we are done */
>  	if (MUSB_EP0_STATUS == musb->ep0_stage) {
> @@ -1131,7 +1131,7 @@ irqreturn_t musb_h_ep0_irq(struct musb *musb)
>  	if (unlikely(!urb)) {
>  		/* stop endpoint since we have no place for its data, this
>  		 * SHOULD NEVER HAPPEN! */
> -		ERR("no URB for end 0\n");
> +		musb_err(musb, "no URB for end 0");
>  
>  		musb_h_ep0_flush_fifo(hw_ep);
>  		goto done;
> @@ -1220,8 +1220,8 @@ void musb_host_tx(struct musb *musb, u8 epnum)
>  	pipe = urb->pipe;
>  	dma = is_dma_capable() ? hw_ep->tx_channel : NULL;
>  	trace_musb_urb_tx(musb, urb);
> -	musb_dbg(musb, "OUT/TX%d end, csr %04x%s", epnum, tx_csr,
> -			dma ? ", dma" : "");
> +	musb_dbg(musb, "OUT/TX%d end, csr %04x%s",
> +		 epnum, tx_csr, dma ? ", dma" : "");
>  
>  	/* check for errors */
>  	if (tx_csr & MUSB_TXCSR_H_RXSTALL) {
> @@ -1349,8 +1349,8 @@ void musb_host_tx(struct musb *musb, u8 epnum)
>  		 */
>  		if (tx_csr & (MUSB_TXCSR_FIFONOTEMPTY | MUSB_TXCSR_TXPKTRDY)) {
>  			musb_dbg(musb,
> -				"DMA complete but FIFO not empty, CSR %04x",
> -				tx_csr);
> +				 "DMA complete but FIFO not empty, CSR %04x",
> +				 tx_csr);
>  			return;
>  		}
>  	}
> @@ -1635,7 +1635,7 @@ static int musb_rx_dma_in_inventra_cppi41(struct dma_controller *dma,
>  				urb->error_count++;
>  			}
>  			musb_dbg(musb, "** OVERFLOW %d into %d",
> -				rx_count, d->length);
> +				 rx_count, d->length);
>  
>  			length = d->length;
>  		} else
> @@ -1758,7 +1758,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
>  		 * with fifo full.  (Only with DMA??)
>  		 */
>  		musb_dbg(musb, "BOGUS RX%d ready, csr %04x, count %d",
> -			epnum, val, musb_readw(epio, MUSB_RXCOUNT));
> +			 epnum, val, musb_readw(epio, MUSB_RXCOUNT));
>  		musb_h_flush_rxfifo(hw_ep, MUSB_RXCSR_CLRDATATOG);
>  		return;
>  	}
> @@ -1820,7 +1820,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
>  		}
>  	} else if (rx_csr & MUSB_RXCSR_INCOMPRX) {
>  		musb_dbg(musb, "end %d high bandwidth incomplete ISO packet RX",
> -				epnum);
> +			 epnum);
>  		status = -EPROTO;
>  	}
>  
> @@ -1840,7 +1840,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
>  
>  	if (unlikely(dma_channel_status(dma) == MUSB_DMA_STATUS_BUSY)) {
>  		/* SHOULD NEVER HAPPEN ... but at least DaVinci has done it */
> -		ERR("RX%d dma busy, csr %04x\n", epnum, rx_csr);
> +		musb_err(musb, "RX%d dma busy, csr %04x", epnum, rx_csr);
>  		goto finish;
>  	}
>  
> @@ -1864,8 +1864,8 @@ void musb_host_rx(struct musb *musb, u8 epnum)
>  			done = true;
>  		}
>  
> -		musb_dbg(musb, "RXCSR%d %04x, reqpkt, len %zu%s", epnum, rx_csr,
> -				xfer_len, dma ? ", dma" : "");
> +		musb_dbg(musb, "RXCSR%d %04x, reqpkt, len %zu%s",
> +			 epnum, rx_csr, xfer_len, dma ? ", dma" : "");
>  		rx_csr &= ~MUSB_RXCSR_H_REQPKT;
>  
>  		musb_ep_select(mbase, epnum);
> @@ -1886,10 +1886,10 @@ void musb_host_rx(struct musb *musb, u8 epnum)
>  		    musb_dma_cppi41(musb)) {
>  			    done = musb_rx_dma_inventra_cppi41(c, hw_ep, qh, urb, xfer_len);
>  			    musb_dbg(hw_ep->musb,
> -				    "ep %d dma %s, rxcsr %04x, rxcount %d",
> -				    epnum, done ? "off" : "reset",
> -				    musb_readw(epio, MUSB_RXCSR),
> -				    musb_readw(epio, MUSB_RXCOUNT));
> +				     "ep %d dma %s, rxcsr %04x, rxcount %d",
> +				     epnum, done ? "off" : "reset",
> +				     musb_readw(epio, MUSB_RXCSR),
> +				     musb_readw(epio, MUSB_RXCOUNT));
>  		} else {
>  			done = true;
>  		}
> @@ -1898,7 +1898,7 @@ void musb_host_rx(struct musb *musb, u8 epnum)
>  		/* if no errors, be sure a packet is ready for unloading */
>  		if (unlikely(!(rx_csr & MUSB_RXCSR_RXPKTRDY))) {
>  			status = -EPROTO;
> -			ERR("Rx interrupt with no errors or packet!\n");
> +			musb_err(musb, "Rx interrupt with no errors or packet!");
>  
>  			/* FIXME this is another "SHOULD NEVER HAPPEN" */
>  
> @@ -1914,12 +1914,10 @@ void musb_host_rx(struct musb *musb, u8 epnum)
>  		if ((musb_dma_inventra(musb) || musb_dma_ux500(musb) ||
>  		    musb_dma_cppi41(musb)) && dma) {
>  			musb_dbg(hw_ep->musb,
> -				"RX%d count %d, buffer 0x%llx len %d/%d",
> -				epnum, musb_readw(epio, MUSB_RXCOUNT),
> -				(unsigned long long) urb->transfer_dma
> -				+ urb->actual_length,
> -				qh->offset,
> -				urb->transfer_buffer_length);
> +				 "RX%d count %d, buffer 0x%llx len %d/%d",
> +				 epnum, musb_readw(epio, MUSB_RXCOUNT),
> +				 (u64)urb->transfer_dma + urb->actual_length,
> +				 qh->offset, urb->transfer_buffer_length);
>  
>  			if (musb_rx_dma_in_inventra_cppi41(c, hw_ep, qh, urb,
>  							   xfer_len, iso_err))
> @@ -2324,8 +2322,7 @@ static int musb_cleanup_urb(struct urb *urb, struct musb_qh *qh)
>  		if (dma) {
>  			status = ep->musb->dma_controller->channel_abort(dma);
>  			musb_dbg(musb, "abort %cX%d DMA for urb %p --> %d",
> -				is_in ? 'R' : 'T', ep->epnum,
> -				urb, status);
> +				 is_in ? 'R' : 'T', ep->epnum, urb, status);
>  			urb->actual_length += dma->actual_len;
>  		}
>  	}
> @@ -2524,11 +2521,12 @@ static int musb_bus_suspend(struct usb_hcd *hcd)
>  	}
>  
>  	if (musb->is_active) {
> -		WARNING("trying to suspend as %s while active\n",
> -				usb_otg_state_string(musb->xceiv->otg->state));
> +		musb_warn(musb, "trying to suspend as %s while active",
> +			  usb_otg_state_string(musb->xceiv->otg->state));
>  		return -EBUSY;
> -	} else
> -		return 0;
> +	}
> +
> +	return 0;
>  }
>  
>  static int musb_bus_resume(struct usb_hcd *hcd)
> diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
> index cafc69536e1d..065fdb8b91e0 100644
> --- a/drivers/usb/musb/musb_virthub.c
> +++ b/drivers/usb/musb/musb_virthub.c
> @@ -102,7 +102,7 @@ int musb_port_suspend(struct musb *musb, bool do_suspend)
>  			break;
>  		default:
>  			musb_dbg(musb, "bogus rh suspend? %s",
> -				usb_otg_state_string(musb->xceiv->otg->state));
> +				 usb_otg_state_string(musb->xceiv->otg->state));
>  		}
>  	} else if (power & MUSB_POWER_SUSPENDM) {
>  		power &= ~MUSB_POWER_SUSPENDM;
> @@ -221,7 +221,7 @@ void musb_root_disconnect(struct musb *musb)
>  		break;
>  	default:
>  		musb_dbg(musb, "host disconnect (%s)",
> -			usb_otg_state_string(musb->xceiv->otg->state));
> +			 usb_otg_state_string(musb->xceiv->otg->state));
>  	}
>  }
>  EXPORT_SYMBOL_GPL(musb_root_disconnect);
> diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> index 0aacfc8be5a1..d8130f58bca3 100644
> --- a/drivers/usb/musb/musbhsdma.c
> +++ b/drivers/usb/musb/musbhsdma.c
> @@ -152,7 +152,7 @@ static void configure_channel(struct dma_channel *channel,
>  	u16 csr = 0;
>  
>  	musb_dbg(musb, "%p, pkt_sz %d, addr %pad, len %d, mode %d",
> -			channel, packet_sz, &dma_addr, len, mode);
> +		 channel, packet_sz, &dma_addr, len, mode);
>  
>  	if (mode) {
>  		csr |= 1 << MUSB_HSDMA_MODE1_SHIFT;
> @@ -187,9 +187,9 @@ static int dma_channel_program(struct dma_channel *channel,
>  	struct musb *musb = controller->private_data;
>  
>  	musb_dbg(musb, "ep%d-%s pkt_sz %d, dma_addr %pad length %d, mode %d",
> -		musb_channel->epnum,
> -		musb_channel->transmit ? "Tx" : "Rx",
> -		packet_sz, &dma_addr, len, mode);
> +		 musb_channel->epnum,
> +		 musb_channel->transmit ? "Tx" : "Rx",
> +		 packet_sz, &dma_addr, len, mode);
>  
>  	BUG_ON(channel->status == MUSB_DMA_STATUS_UNKNOWN ||
>  		channel->status == MUSB_DMA_STATUS_BUSY);
> @@ -329,12 +329,12 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
>  					- musb_channel->start_addr;
>  
>  				musb_dbg(musb, "ch %p, 0x%x -> 0x%x (%zu / %d) %s",
> -					channel, musb_channel->start_addr,
> -					addr, channel->actual_len,
> -					musb_channel->len,
> -					(channel->actual_len
> -						< musb_channel->len) ?
> -					"=> reconfig 0" : "=> complete");
> +					 channel, musb_channel->start_addr,
> +					 addr, channel->actual_len,
> +					 musb_channel->len,
> +					 (channel->actual_len
> +					  < musb_channel->len) ?
> +					 "=> reconfig 0" : "=> complete");
>  
>  				devctl = musb_readb(mbase, MUSB_DEVCTL);
>  
> diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
> index c42937692207..4147c361bfc6 100644
> --- a/drivers/usb/musb/tusb6010.c
> +++ b/drivers/usb/musb/tusb6010.c
> @@ -667,8 +667,8 @@ static int tusb_musb_set_mode(struct musb *musb, u8 musb_mode)
>  	otg_stat = musb_readl(tbase, TUSB_DEV_OTG_STAT);
>  	if ((musb_mode == MUSB_PERIPHERAL) &&
>  		!(otg_stat & TUSB_DEV_OTG_STAT_ID_STATUS))
> -			INFO("Cannot be peripheral with mini-A cable "
> -			"otg_stat: %08x\n", otg_stat);
> +		musb_info(musb, "Cannot be peripheral with mini-A cable otg_stat: %08x",
> +			  otg_stat);
>  
>  	return 0;
>  }
> @@ -793,7 +793,8 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *tbase)
>  					+ msecs_to_jiffies(musb->a_wait_bcon);
>  			} else {
>  				/* REVISIT report overcurrent to hub? */
> -				ERR("vbus too slow, devctl %02x\n", devctl);
> +				musb_err(musb, "vbus too slow, devctl %02x",
> +					 devctl);
>  				tusb_musb_set_vbus(musb, 0);
>  			}
>  			break;
> @@ -957,8 +958,7 @@ static void tusb_musb_enable(struct musb *musb)
>  				TUSB_INT_SRC_ID_STATUS_CHNG);
>  
>  	if (is_dma_capable() && dma_off)
> -		printk(KERN_WARNING "%s %s: dma not reactivated\n",
> -				__FILE__, __func__);
> +		musb_warn(musb, "dma not reactivated");
>  	else
>  		dma_off = 1;
>  }
> @@ -981,8 +981,7 @@ static void tusb_musb_disable(struct musb *musb)
>  	del_timer(&musb->dev_timer);
>  
>  	if (is_dma_capable() && !dma_off) {
> -		printk(KERN_WARNING "%s %s: dma still active\n",
> -				__FILE__, __func__);
> +		musb_warn(musb, "dma still active");
>  		dma_off = 1;
>  	}
>  }
> @@ -1028,7 +1027,7 @@ static int tusb_musb_start(struct musb *musb)
>  	if (musb->board_set_power)
>  		ret = musb->board_set_power(1);
>  	if (ret != 0) {
> -		printk(KERN_ERR "tusb: Cannot enable TUSB6010\n");
> +		musb_err(musb, "tusb: Cannot enable TUSB6010");
>  		return ret;
>  	}
>  
> @@ -1036,15 +1035,15 @@ static int tusb_musb_start(struct musb *musb)
>  
>  	if (musb_readl(tbase, TUSB_PROD_TEST_RESET) !=
>  		TUSB_PROD_TEST_RESET_VAL) {
> -		printk(KERN_ERR "tusb: Unable to detect TUSB6010\n");
> +		musb_err(musb, "tusb: Unable to detect TUSB6010");
>  		goto err;
>  	}
>  
>  	musb->tusb_revision = tusb_get_revision(musb);
>  	tusb_print_revision(musb);
>  	if (musb->tusb_revision < 2) {
> -		printk(KERN_ERR "tusb: Unsupported TUSB6010 revision %i\n",
> -				musb->tusb_revision);
> +		musb_err(musb, "tusb: Unsupported TUSB6010 revision %i",
> +			 musb->tusb_revision);
>  		goto err;
>  	}
>  
> @@ -1129,8 +1128,7 @@ static int tusb_musb_init(struct musb *musb)
>  
>  	ret = tusb_musb_start(musb);
>  	if (ret) {
> -		printk(KERN_ERR "Could not start tusb6010 (%d)\n",
> -				ret);
> +		musb_err(musb, "Could not start tusb6010 (%d)", ret);
>  		goto done;
>  	}
>  	musb->isr = tusb_musb_interrupt;
> diff --git a/drivers/usb/musb/tusb6010_omap.c b/drivers/usb/musb/tusb6010_omap.c
> index 60a93b8bbe3c..88f2923cfdc4 100644
> --- a/drivers/usb/musb/tusb6010_omap.c
> +++ b/drivers/usb/musb/tusb6010_omap.c
> @@ -83,8 +83,8 @@ static inline void tusb_omap_free_shared_dmareq(struct tusb_omap_dma_ch *chdat)
>  	u32		reg = musb_readl(chdat->tbase, TUSB_DMA_EP_MAP);
>  
>  	if ((reg & 0xf) != chdat->epnum) {
> -		printk(KERN_ERR "ep%i trying to release dmareq0 for ep%i\n",
> -			chdat->epnum, reg & 0xf);
> +		musb_err(chdat->musb, "ep%i trying to release dmareq0 for ep%i",
> +			 chdat->epnum, reg & 0xf);
>  		return;
>  	}
>  	musb_writel(chdat->tbase, TUSB_DMA_EP_MAP, 0);
> diff --git a/drivers/usb/musb/ux500_dma.c b/drivers/usb/musb/ux500_dma.c
> index d5cf5e8bb1ca..9979a733954d 100644
> --- a/drivers/usb/musb/ux500_dma.c
> +++ b/drivers/usb/musb/ux500_dma.c
> @@ -323,8 +323,8 @@ static int ux500_dma_controller_start(struct ux500_dma_controller *controller)
>  							    NULL);
>  
>  			if (!ux500_channel->dma_chan) {
> -				ERR("Dma pipe allocation error dir=%d ch=%d\n",
> -					dir, ch_num);
> +				musb_err(musb, "Dma pipe allocation error dir=%d ch=%d",
> +					 dir, ch_num);
>  
>  				/* Release already allocated channels */
>  				ux500_dma_controller_stop(controller);
>
>

