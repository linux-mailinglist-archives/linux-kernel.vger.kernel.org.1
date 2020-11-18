Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFB72B81F8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgKRQco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgKRQco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:32:44 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C266C0613D4;
        Wed, 18 Nov 2020 08:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:In-Reply-To:MIME-Version:
        Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TAY1++iLWMBmjkCvO7bo2+XOKYUcM8CQHJLY0u3ulxE=; b=ppfn7StiK/7gQsS55yRWhWGD3u
        V6sQK+gL8G+cqkq6yg/vMvqB/EWKTeAxixnC/yBCAWgJMYMDZYCHgLQdviH7gUfhSKuW8YEqGKV/1
        qmd24D8sRZnp7WEADFmUMElIbUmK+LGGxtHMupDPMwJCrfCflwDjcvYg4fPGXSvZJlsYNvSvqmTUc
        DaJWP8uDzp/M5KXJmB1c+MGH5B9+0zSTz8dCuEcIDyYI09ucnyq8NkaAC8CWoiQWdo6XQpGC+KJpR
        m/E4xx+9KWzATQtI5ePEKU4JpraHv62OKS0sjB7T5glk8NqQWZiqFRDJr+SrHFeqNp5DWLtNF0xVS
        F9JfuIoA==;
Received: from [2601:1c0:6280:3f0::bcc4]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfQNs-0004JE-M6; Wed, 18 Nov 2020 16:32:41 +0000
Subject: Re: [RFC] Add kernel-doc test script
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20201030144713.201372-1-pbonzini@redhat.com>
 <20201030144713.201372-3-pbonzini@redhat.com>
 <20201113152106.7b4a07ee@lwn.net>
 <20201113223912.GK17076@casper.infradead.org>
 <20201117212452.GM1235237@habkost.net>
 <20201117213051.GA29991@casper.infradead.org>
 <20201117223612.GN1235237@habkost.net>
 <16145b8b-3213-8bc9-1826-d3ae006f78fa@infradead.org>
 <20201118130344.GD1509407@habkost.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b0d6dc09-49ea-f96e-278a-6fc0f78de810@infradead.org>
Date:   Wed, 18 Nov 2020 08:32:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201118130344.GD1509407@habkost.net>
Content-Type: multipart/mixed;
 boundary="------------F81CF100721AEEBDC6EE764B"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F81CF100721AEEBDC6EE764B
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 11/18/20 5:03 AM, Eduardo Habkost wrote:
> On Tue, Nov 17, 2020 at 04:23:49PM -0800, Randy Dunlap wrote:
>> On 11/17/20 2:36 PM, Eduardo Habkost wrote:
>>> Add a kernel-doc test script to tools/testing/kernel-doc.
>>>
>>> radix_tree_lookup_slot test case provided by Matthew Wilcox.
>>>
>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>
>> Very good idea.
>>
>> I have had a kernel-doc test source file for (?) 10-12 years,
>> while I was the docs maintainer.
> 
> Is that test source file recoverable somewhere?  It probably has
> useful test cases not included here.

Sure.  Of course, it may be out of date by quite a bit.
I last updated it in 2016:
-rw-r--r-- 1 rdunlap users  41737 Jun 17  2016 megatest.c

(attached)

-- 
~Randy


--------------F81CF100721AEEBDC6EE764B
Content-Type: text/x-csrc; charset=UTF-8;
 name="megatest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="megatest.c"

/**
 * struct my_struct - short description
 * @a: first member
 * @b: second member
 *
 * Longer description
 */
struct my_struct {
    int a;
    int b;
/* private: */
    int c;
};

struct scan_channel;
/**
 * struct scan_params - describes scan parameters
 * @n_channels: number of items in @channels array or -1 to indicate all
 *      channels should be scanned (in that case @channels will be %NULL)
 * @active: when n_channels is -1 this determines active/passive scanning.
 * @phymode: when n_channels is -1 this determines PHY mode to scan. It is
 *      not possible to scan different PHY modes in one request w/o giving
 *      a channel list.
 * @channels: array containing @n_channels &scan_channel items
 */
struct scan_params {
	int n_channels;
	int active;
	int phymode;
	struct scan_channel *channels;
};

/**
 * typedef __kernel_fd_set - set of file descriptor bits
 * @fds_bits: bitmask for all file descriptors, used in poll/select
 */
typedef struct {
	unsigned long fds_bits [__FDSET_LONGS]; // what prints this out?
} __kernel_fd_set;

/**
 * typedef __kernel_sighandler_t - Type of a signal handler.
 */
typedef void (*__kernel_sighandler_t)(int);

/**
 * typedef __kernel_key_t - Type of a SYSV IPC key.
 */
typedef int __kernel_key_t;


/**
 * typedef cpumask_var_t - type of a struct cpumask on-stack array
 */
typedef struct cpumask cpumask_var_t[1];

/**
 * typedef note_buf_t - type for kexec kernel crash note buffer
 */
typedef u32 note_buf_t[KEXEC_NOTE_BYTES/4];

/**
 * typedef nfs4_verifier - struct for NFS4 verifier data
 */
typedef struct { char data[NFS4_VERIFIER_SIZE]; } nfs4_verifier;

/**
 * typedef match_table_t - type for file options parser match_token table
 */
typedef struct match_token match_table_t[];


/**
 * struct acpi_interrupt_flags - with bitfields
 * @polarity: active high or active low
 * @trigger: edge or level triggered
 * @reserved: not used
 */
struct acpi_interrupt_flags {
	u16			polarity:2;
	u16			trigger:2;
	u16			reserved:12;
} __attribute__ ((packed));

/**
 * typedef phys_drive_t - physical device information
 * @type	: Type of the device
 * @cur_status	: current status of the device
 * @tag_depth	: Level of tagging
 * @sync_neg	: sync negotiation - ENABLE or DISBALE
 * @size	: configurable size in terms of 512 byte
 */
typedef struct {
	uint8_t		type;
	uint8_t		cur_status;
	uint8_t		tag_depth;
	uint8_t		sync_neg;
	uint32_t	size;
}__attribute__ ((packed)) phys_drive_t;

/**
 * mraid_mm_open - open routine for char node interface
 * @inode	: unused, but never the same as &filep
 * @filep	: unused, but never the same as &inodep
 *
 * Allow ioctl operations by apps only if they have superuser privilege.
 * Returns %0 on success, -%EACCES on error.
 * Never uses $ENV variables.
 */
static int // strip C99-comment
mraid_mm_open(struct inode *inode, struct file *filep)
// drop entire line
{
}

/**
 * megaraid_queue_command - generic queue entry point for all LLDs
 * @scp		: pointer to the scsi command to be executed
 * @done	: callback routine to be called after the cmd has be completed
 *
 * Queue entry point for mailbox based controllers.
 */
static int
megaraid_queue_command(struct scsi_cmnd *scp, void (* done)(struct scsi_cmnd *))
{
}

struct sub_channels {
	unsigned int	flags;
	int		max_size;
	int		cur_size;
};

/**
 * struct channels - struct for testing kernel-doc
 * @n_sub_channels: number of &struct sub_channels pointers included
 * @flags: flags for all channels
 * @reserved: not yet used
 * @sub_channels: the sub-channels
 */
struct channels {
	int n_sub_channels;
	unsigned int flags;
	int reserved;
	struct sub_channels *sub_channels;
};

/**
 * clk_get - lookup and obtain a reference to a clock producer.
 * @dev: device for clock "consumer"
 * @id: clock consumer ID
 *
 * Returns a &struct clk corresponding to the clock producer, or
 * valid IS_ERR() condition containing errno.  The implementation
 * uses @dev and @id to determine the clock consumer, and thereby
 * the clock producer.  (IOW, @id may be identical strings, but
 * clk_get may return different clock producers depending on @dev.)
 *
 * Drivers must assume that the clock source is not enabled.
 *
 * Returns %NULL if a reference is not obtained.  (for kernel-doc testing only.)
 * However, if $CLKTEST is non-%NULL, some random value is returned.
 */
struct clk *clk_get(struct device *dev, const char *id);

/** 
 *	struct sk_buff - socket buffer
 *	@next: Next buffer in list
 *	@prev: Previous buffer in list
 *	@sk: Socket we are owned by
 *	@tstamp: Time we arrived
 *	@dev: Device we arrived on/are leaving by
 *	@iif: ifindex of device we arrived on
 *	@transport_header: Transport layer header
 *	@network_header: Network layer header
 *	@mac_header: Link layer header
 *	@dst: destination entry
 *	@sp: the security path, used for xfrm
 *	@cb: Control buffer. Free for use by every layer. Put private vars here
 *	@len: Length of actual data
 *	@data_len: Data length
 *	@mac_len: Length of link layer header
 *	@csum: Checksum (must include start/offset pair)
 *	@csum_start: Offset from skb->head where checksumming should start
 *	@csum_offset: Offset from csum_start where checksum should be stored
 *	@local_df: allow local fragmentation
 *	@cloned: Head may be cloned (check refcnt to be sure)
 *	@nohdr: Payload reference only, must not modify header
 *	@pkt_type: Packet class
 *	@fclone: skbuff clone status
 *	@ip_summed: Driver fed us an IP checksum
 *	@priority: Packet queueing priority
 *	@users: User count - see {datagram,tcp}.c
 *	@protocol: Packet protocol from driver
 *	@truesize: Buffer size 
 *	@head: Head of buffer
 *	@data: Data head pointer
 *	@tail: Tail pointer
 *	@end: End pointer
 *	@destructor: Destruct function
 *	@mark: Generic packet mark
 *	@nfct: Associated connection, if any
 *	@ipvs_property: skbuff is owned by ipvs
 *	@nfctinfo: Relationship of this skb to the connection
 *	@nfct_reasm: netfilter conntrack re-assembly pointer
 *	@nf_bridge: Saved data about a bridged frame - see br_netfilter.c
 *	@tc_index: Traffic control index
 *	@tc_verd: traffic control verdict
 *	@dma_cookie: a cookie to one of several possible DMA operations
 *		done by skb DMA functions
 *	@secmark: security marking
 */

struct sk_buff {
	/* These two members must be first. */
	struct sk_buff		*next;
	struct sk_buff		*prev;

	struct sock		*sk;
	ktime_t			tstamp;
	struct net_device	*dev;
	int			iif;
	/* 4 byte hole on 64 bit*/

	struct  dst_entry	*dst;
	struct	sec_path	*sp;

	/*
	 * This is the control buffer. It is free to use for every
	 * layer. Please put your private variables there. If you
	 * want to keep them across layers you have to do a skb_clone()
	 * first. This is owned by whoever has the skb queued ATM.
	 */
	char			cb[48];

	unsigned int		len,
				data_len,
				mac_len;
	union {		// fields inside structs/unions are not listed
		__wsum		csum;
		struct {
			__u16	csum_start;
			__u16	csum_offset;
		};
	};
	__u32			priority;
	__u8			local_df:1,
				cloned:1,
				ip_summed:2,
				nohdr:1,
				nfctinfo:3;
	__u8			pkt_type:3,
				fclone:2,
				ipvs_property:1;
	__be16			protocol;

	void			(*destructor)(struct sk_buff *skb);
#if defined(CONFIG_NF_CONNTRACK) || defined(CONFIG_NF_CONNTRACK_MODULE)
	struct nf_conntrack	*nfct;
	struct sk_buff		*nfct_reasm;
#endif
#ifdef CONFIG_BRIDGE_NETFILTER
	struct nf_bridge_info	*nf_bridge;
#endif
#ifdef CONFIG_NET_SCHED
	__u16			tc_index;	/* traffic control index */
#ifdef CONFIG_NET_CLS_ACT
	__u16			tc_verd;	/* traffic control verdict */
#endif
#endif
#ifdef CONFIG_NET_DMA
	dma_cookie_t		dma_cookie;
#endif
#ifdef CONFIG_NETWORK_SECMARK
	__u32			secmark;
#endif

	__u32			mark;

	// layers headers:
	sk_buff_data_t		transport_header;
	sk_buff_data_t		network_header;
	sk_buff_data_t		mac_header;
	/* These elements must be at the end, see alloc_skb() for details.  */
	sk_buff_data_t		tail;
	sk_buff_data_t		end;
	unsigned char		*head,
				*data;
	unsigned int		truesize;
	atomic_t		users;
};

/**
 * struct anon_test - test anon struct/union ending lines
 * @last_field: last field in the struct
 */
struct anon_test {
	union {		// fields inside structs/unions are not listed
		__wsum		csum;
		__wsum		zeta;
		__u32		beta;
	};
	int			last_field;
};

/**
 * struct anon_test2 - test anon struct/union ending lines
 * @some_field: some field in the struct
 */
struct anon_test2 {
	int			some_field;
	union {		// fields inside structs/unions are not listed
		__wsum		csum;
		__wsum		zeta;
		__u32		beta;
	};
};

/**
 * el1_probe - probe for a 3c501
 * @unit: device number
 *
 * This can be called from two places. The network layer will probe using
 * a device structure passed in with the probe information completed. For a
 * modular driver we use #init_module to fill in our own structure and probe
 * for it.
 *
 * Returns 0 on success. ENXIO if asked not to probe and ENODEV if asked to
 * probe and failing to find anything.
 */
struct net_device * __init el1_probe(int unit)
{
}

/**
 *	parport_register_device - register a device on a parallel port
 *	@port: port to which the device is attached
 *	@name: a name to refer to the device
 *	@pf: preemption callback
 *	@kf: kick callback (wake-up)
 *	@irq_func: interrupt handler
 *	@flags: registration flags
 *	@handle: data for callback functions
 *
 *	This function, called by parallel port device drivers,
 *	declares that a device is connected to a port, and tells the
 *	system all it needs to know.
 *
 *	The @name is allocated by the caller and must not be
 *	deallocated until the caller calls @parport_unregister_device
 *	for that device.
 *
 *	The preemption callback function, @pf, is called when this
 *	device driver has claimed access to the port but another
 *	device driver wants to use it.  It is given @handle as its
 *	parameter, and should return zero if it is willing for the
 *	system to release the port to another driver on its behalf.
 *	If it wants to keep control of the port it should return
 *	non-zero, and no action will be taken.  It is good manners for
 *	the driver to try to release the port at the earliest
 *	opportunity after its preemption callback rejects a preemption
 *	attempt.  Note that if a preemption callback is happy for
 *	preemption to go ahead, there is no need to release the port;
 *	it is done automatically.  This function may not block, as it
 *	may be called from interrupt context.  If the device driver
 *	does not support preemption, @pf can be %NULL.
 *
 *	The wake-up ("kick") callback function, @kf, is called when
 *	the port is available to be claimed for exclusive access; that
 *	is, parport_claim() is guaranteed to succeed when called from
 *	inside the wake-up callback function.  If the driver wants to
 *	claim the port it should do so; otherwise, it need not take
 *	any action.  This function may not block, as it may be called
 *	from interrupt context.  If the device driver does not want to
 *	be explicitly invited to claim the port in this way, @kf can
 *	be %NULL.
 *
 *	The interrupt handler, @irq_func, is called when an interrupt
 *	arrives from the parallel port.  Note that if a device driver
 *	wants to use interrupts it should use parport_enable_irq(),
 *	and can also check the irq member of the parport structure
 *	representing the port.
 *
 *	The parallel port (lowlevel) driver is the one that has called
 *	request_irq() and whose interrupt handler is called first.
 *	This handler does whatever needs to be done to the hardware to
 *	acknowledge the interrupt (for PC-style ports there is nothing
 *	special to be done).  It then tells the IEEE 1284 code about
 *	the interrupt, which may involve reacting to an IEEE 1284
 *	event depending on the current IEEE 1284 phase.  After this,
 *	it calls @irq_func.  Needless to say, @irq_func will be called
 *	from interrupt context, and may not block.
 *
 *	The %PARPORT_DEV_EXCL flag is for preventing port sharing, and
 *	so should only be used when sharing the port with other device
 *	drivers is impossible and would lead to incorrect behaviour.
 *	Use it sparingly!  Normally, @flags will be zero.
 *
 *	This function returns a pointer to a structure that represents
 *	the device on the port, or %NULL if there is not enough memory
 *	to allocate space for that structure.
 **/
struct pardevice *
parport_register_device(struct parport *port, const char *name,
			int (*pf)(void *), void (*kf)(void *),
			void (*irq_func)(int, void *), 
			int flags, void *handle)
{
}


/**
 * atomic_set - set atomic variable
 * @v: pointer of type atomic_t
 * @i: required value
 * 
 * Atomically sets the value of @v to @i.
 */ 
#define atomic_set(v,i)		(((v)->counter) = (i))

/**
 * atomic_set_varargs - set atomic variable
 * @v: pointer of type atomic_t
 * @i: required value
 * @...: more varargs
 * 
 * Atomically sets the value of @v to @i.
 */ 
#define atomic_set_varargs(v,i, ...)		(((v)->counter) = (i))


/**
 * ntfs_debug - write a debug level message to syslog
 * @f:		a printf format string containing the message
 * @...:	the variables to substitute into @f
 *
 * ntfs_debug() writes a DEBUG level message to the syslog but only if the
 * driver was compiled with -DDEBUG. Otherwise, the call turns into a NOP.
 */
static void ntfs_debug(const char *f, ...);


/**
 * __copy_to_user: - Copy a block of data into user space, with less checking.
 * @to:   Destination address, in user space.
 * @from: Source address, in kernel space.
 * @n:    Number of bytes to copy.
 *
 * Context: User context only.  This function may sleep.
 *
 * Copy data from kernel space to user space.  Caller must check
 * the specified block with access_ok() before calling this function.
 *
 * Returns number of bytes that could not be copied.
 * On success, this will be zero.
 */
static __always_inline unsigned long __must_check
__copy_to_user(void __user *to, const void *from, unsigned long n)
{
}


/**
 * pci_match_device - Tell if a PCI device structure has a matching PCI device id structure
 * @drv: the PCI driver to match against
 * @dev: the PCI device structure to match against
 *
 * Used by a driver to check whether a PCI device present in the
 * system is in its list of supported devices.  Returns the matching
 * pci_device_id structure or %NULL if there is no match.
 */
const struct pci_device_id *pci_match_device(struct pci_driver *drv,
					     struct pci_dev *dev)
{
}

/**
 * shost_for_each_device - iterate over all devices of a host
 * @sdev: the &struct scsi_device to use as a cursor
 * @shost: the &struct scsi_host to iterate over
 *
 * Iterator that returns each device attached to @shost.  This loop
 * takes a reference on each device and releases it at the end.  If
 * you break out of the loop, you must call scsi_device_put(sdev).
 */
#define shost_for_each_device(sdev, shost) \
	for ((sdev) = __scsi_iterate_devices((shost), NULL); \
	     (sdev); \
	     (sdev) = __scsi_iterate_devices((shost), (sdev)))

/**
 * __shost_for_each_device - iterate over all devices of a host (UNLOCKED)
 * @sdev: the &struct scsi_device to use as a cursor
 * @shost: the &struct scsi_host to iterate over
 *
 * Iterator that returns each device attached to @shost.  It does _not_
 * take a reference on the scsi_device, so the whole loop must be
 * protected by shost->host_lock.
 *
 * Note: The only reason to use this is because you need to access the
 * device list in interrupt context.  Otherwise you really want to use
 * shost_for_each_device instead.
 */
#define __shost_for_each_device(sdev, shost) \
	list_for_each_entry((sdev), &((shost)->__devices), siblings)

//BAD: TBD: try to detect this:
/**
 * scsi_devinfo: set up the dynamic device list.
 *
 * The short function description above is in invalid format and
 * is probably missing in the generated output.
 */
int scsi_devinfo(void)
{
}

/**
 * scsi_init_devinfo - set up the dynamic device list.
 *
 * Description:
 *
 * blank line1 above & below here should be kept as is, not deleted.
 *
 * 	Init all devinfo list entries and then add
 * 	scsi_static_device_list entries to the scsi device info list.
 *
 * blank line2 above & below here should be kept as is, not deleted.
 *
 **/
int __init scsi_init_devinfo(void)
{
}

/**
 *	vunmap  -  release virtual mapping obtained by vmap()
 *	@addr:		memory base address
 *
 *	Free the virtually contiguous memory area starting at @addr,
 *	which was created from the page array passed to vmap().
 *
 *	Must not be called in interrupt context.
 *
 *	Returns a pointer to the array of pointers to page structs
 */
struct page **vunmap(const void *addr)
{
	BUG_ON(in_interrupt());
	return __vunmap(addr, 0);
}

/**
 * blk_end_io - Generic end_io function to complete a request.
 * @rq:           the request being processed
 * @error:        0 for success, < 0 for error
 * @nr_bytes:     number of bytes to complete @rq
 * @bidi_bytes:   number of bytes to complete @rq->next_rq
 * @drv_callback: function called between completion of bios in the request
 *                and completion of the request.
 *                If the callback returns non 0, this helper returns without
 *                completion of the request.
 *
 * Description:
 *     Ends I/O on a number of bytes attached to @rq and @rq->next_rq.
 *     If @rq has leftover, sets it up for the next range of segments.
 *
 * Return:
 *     0 - we are done with this request
 *     1 - this request is not freed yet, it still has pending buffers.
 **/
static int blk_end_io(struct request *rq, int error, unsigned int nr_bytes,
		      unsigned int bidi_bytes,
		      int (drv_callback)(struct request *))
{
}

/**
 * func_with_dup_note_sections - any old function
 *
 * Note: each "section" (as indicated by "word:") should have a unique section-word
 * identifier.
 *
 * Note1: teach kernel-doc to notice when it clobbers a previous section contents.
 */
static void func_with_dup_note_sections(void)
{
}

/**
 * func_name_short_desc_test() -- any old function
 *
 * Note2: Just see how the output looks when () and -- are used.
 */
static void func_name_short_desc_test(void)
{
}

/**
 * notify_cpu_starting(cpu) - call the CPU_STARTING notifiers
 * @cpu: cpu that just started
 *
 * Note3: test for func prm name included.
 */
static void notify_cpu_starting(unsigned int cpu)
{
}

/**
 * struct foobar - documented
 *
 * This is a struct whose members are all private.
 */
struct foobar {
/* private: */
	int foo;
	int bar;
/* public: */
};

/**
 * struct skb_shared_hwtstamps - hardware time stamps
 * @hwtstamp:	hardware time stamp transformed into duration
 *		since arbitrary point in time
 * @syststamp:	hwtstamp transformed to system time base
 *
 * Software time stamps generated by ktime_get_real() are stored in
 * skb->tstamp. The relation between the different kinds of time
 * stamps is as follows:
 *
 * syststamp and tstamp can be compared against each other in
 * arbitrary combinations.  The accuracy of a
 * syststamp/tstamp/"syststamp from other device" comparison is
 * limited by the accuracy of the transformation into system time
 * base. This depends on the device driver and its underlying
 * hardware.
 *
 * hwtstamps can only be compared against other hwtstamps from
 * the same device.
 *
 * This structure is attached to packets as part of the
 * &skb_shared_info. Use skb_hwtstamps() to get a pointer.
 */
struct skb_shared_hwtstamps {
	ktime_t	hwtstamp;
	ktime_t	syststamp;
};

/**
 * struct usb_function - describes one function of a configuration
 * @name: For diagnostics, identifies the function.
 * @strings: tables of strings, keyed by identifiers assigned during bind()
 *	and by language IDs provided in control requests
 * @descriptors: Table of full (or low) speed descriptors, using interface and
 *	string identifiers assigned during @bind().  If this pointer is null,
 *	the function will not be available at full speed (or at low speed).
 * @hs_descriptors: Table of high speed descriptors, using interface and
 *	string identifiers assigned during @bind().  If this pointer is null,
 *	the function will not be available at high speed.
 * @config: assigned when @usb_add_function() is called; this is the
 *	configuration with which this function is associated.
 * @bind: Before the gadget can register, all of its functions bind() to the
 *	available resources including string and interface identifiers used
 *	in interface or class descriptors; endpoints; I/O buffers; and so on.
 * @unbind: Reverses @bind; called as a side effect of unregistering the
 *	driver which added this function.
 * @set_alt: (REQUIRED) Reconfigures altsettings; function drivers may
 *	initialize usb_ep.driver data at this time (when it is used).
 *	Note that setting an interface to its current altsetting resets
 *	interface state, and that all interfaces have a disabled state.
 * @get_alt: Returns the active altsetting.  If this is not provided,
 *	then only altsetting zero is supported.
 * @disable: (REQUIRED) Indicates the function should be disabled.  Reasons
 *	include host resetting or reconfiguring the gadget, and disconnection.
 * @setup: Used for interface-specific control requests.
 * @suspend: Notifies functions when the host stops sending USB traffic.
 * @resume: Notifies functions when the host restarts USB traffic.
 *
 * A single USB function uses one or more interfaces, and should in most
 * cases support operation at both full and high speeds.  Each function is
 * associated by @usb_add_function() with a one configuration; that function
 * causes @bind() to be called so resources can be allocated as part of
 * setting up a gadget driver.  Those resources include endpoints, which
 * should be allocated using @usb_ep_autoconfig().
 *
 * To support dual speed operation, a function driver provides descriptors
 * for both high and full speed operation.  Except in rare cases that don't
 * involve bulk endpoints, each speed needs different endpoint descriptors.
 *
 * Function drivers choose their own strategies for managing instance data.
 * The simplest strategy just declares it "static', which means the function
 * can only be activated once.  If the function needs to be exposed in more
 * than one configuration at a given speed, it needs to support multiple
 * usb_function structures (one for each configuration).
 *
 * A more complex strategy might encapsulate a @usb_function structure inside
 * a driver-specific instance structure to allows multiple activations.  An
 * example of multiple activations might be a CDC ACM function that supports
 * two or more distinct instances within the same configuration, providing
 * several independent logical data links to a USB host.
 */
struct usb_function {
	const char			*name;
	struct usb_gadget_strings	**strings;
	struct usb_descriptor_header	**descriptors;
	struct usb_descriptor_header	**hs_descriptors;

	struct usb_configuration	*config;

	/* REVISIT:  bind() functions can be marked __init, which
	 * makes trouble for section mismatch analysis.  See if
	 * we can't restructure things to avoid mismatching.
	 * Related:  unbind() may kfree() but bind() won't...
	 */

	/* configuration management:  bind/unbind */
	int			(*bind)(struct usb_configuration *,
					struct usb_function *);
	void			(*unbind)(struct usb_configuration *,
					struct usb_function *);

	/* runtime state management */
	int			(*set_alt)(struct usb_function *,
					unsigned interface, unsigned alt);
	int			(*get_alt)(struct usb_function *,
					unsigned interface);
	void			(*disable)(struct usb_function *);
	int			(*setup)(struct usb_function *,
					const struct usb_ctrlrequest *);
	void			(*suspend)(struct usb_function *);
	void			(*resume)(struct usb_function *);

	/* private: allow trailing text here, but not leading text before "private:" */
	/* internals */
	struct list_head		list;
};

/**
 * struct urb - USB Request Block
 * @urb_list: For use by current owner of the URB.
 * @anchor_list: membership in the list of an anchor
 * @anchor: to anchor URBs to a common mooring
 * @ep: Points to the endpoint's data structure.  Will eventually
 *	replace @pipe.
 * @pipe: Holds endpoint number, direction, type, and more.
 *	Create these values with the eight macros available;
 *	usb_{snd,rcv}TYPEpipe(dev,endpoint), where the TYPE is "ctrl"
 *	(control), "bulk", "int" (interrupt), or "iso" (isochronous).
 *	For example usb_sndbulkpipe() or usb_rcvintpipe().  Endpoint
 *	numbers range from zero to fifteen.  Note that "in" endpoint two
 *	is a different endpoint (and pipe) from "out" endpoint two.
 *	The current configuration controls the existence, type, and
 *	maximum packet size of any given endpoint.
 * @dev: Identifies the USB device to perform the request.
 * @status: This is read in non-iso completion functions to get the
 *	status of the particular request.  ISO requests only use it
 *	to tell whether the URB was unlinked; detailed status for
 *	each frame is in the fields of the iso_frame-desc.
 * @transfer_flags: A variety of flags may be used to affect how URB
 *	submission, unlinking, or operation are handled.  Different
 *	kinds of URB can use different flags.
 * @transfer_buffer:  This identifies the buffer to (or from) which
 * 	the I/O request will be performed (unless URB_NO_TRANSFER_DMA_MAP
 *	is set).  This buffer must be suitable for DMA; allocate it with
 *	kmalloc() or equivalent.  For transfers to "in" endpoints, contents
 *	of this buffer will be modified.  This buffer is used for the data
 *	stage of control transfers.
 * @transfer_dma: When transfer_flags includes URB_NO_TRANSFER_DMA_MAP,
 *	the device driver is saying that it provided this DMA address,
 *	which the host controller driver should use in preference to the
 *	transfer_buffer.
 * @transfer_buffer_length: How big is transfer_buffer.  The transfer may
 *	be broken up into chunks according to the current maximum packet
 *	size for the endpoint, which is a function of the configuration
 *	and is encoded in the pipe.  When the length is zero, neither
 *	transfer_buffer nor transfer_dma is used.
 * @actual_length: This is read in non-iso completion functions, and
 *	it tells how many bytes (out of transfer_buffer_length) were
 *	transferred.  It will normally be the same as requested, unless
 *	either an error was reported or a short read was performed.
 *	The URB_SHORT_NOT_OK transfer flag may be used to make such
 *	short reads be reported as errors.
 * @setup_packet: Only used for control transfers, this points to eight bytes
 *	of setup data.  Control transfers always start by sending this data
 *	to the device.  Then transfer_buffer is read or written, if needed.
 * @setup_dma: For control transfers with URB_NO_SETUP_DMA_MAP set, the
 *	device driver has provided this DMA address for the setup packet.
 *	The host controller driver should use this in preference to
 *	setup_packet.
 * @start_frame: Returns the initial frame for isochronous transfers.
 * @number_of_packets: Lists the number of ISO transfer buffers.
 * @interval: Specifies the polling interval for interrupt or isochronous
 *	transfers.  The units are frames (milliseconds) for for full and low
 *	speed devices, and microframes (1/8 millisecond) for highspeed ones.
 * @error_count: Returns the number of ISO transfers that reported errors.
 * @context: For use in completion functions.  This normally points to
 *	request-specific driver context.
 * @complete: Completion handler. This URB is passed as the parameter to the
 *	completion function.  The completion function may then do what
 *	it likes with the URB, including resubmitting or freeing it.
 * @iso_frame_desc: Used to provide arrays of ISO transfer buffers and to
 *	collect the transfer status for each buffer.
 */
struct urb {
	/* private: usb core and host controller only fields in the urb */
	struct kref kref;		/* reference count of the URB */
	void *hcpriv;			/* private data for host controller */
	atomic_t use_count;		/* concurrent submissions counter */
	atomic_t reject;		/* submissions will fail */
	int unlinked;			/* unlink error code */

	/* public: documented fields in the urb that can be used by drivers */
	struct list_head urb_list;	/* list head for use by the urb's
					 * current owner */
	struct list_head anchor_list;	/* the URB may be anchored */
	struct usb_anchor *anchor;
	struct usb_device *dev; 	/* (in) pointer to associated device */
	struct usb_host_endpoint *ep;	/* (internal) pointer to endpoint */
	unsigned int pipe;		/* (in) pipe information */
	int status;			/* (return) non-ISO status */
	unsigned int transfer_flags;	/* (in) URB_SHORT_NOT_OK | ...*/
	void *transfer_buffer;		/* (in) associated data buffer */
	dma_addr_t transfer_dma;	/* (in) dma addr for transfer_buffer */
	u32 transfer_buffer_length;	/* (in) data buffer length */
	u32 actual_length;		/* (return) actual transfer length */
	unsigned char *setup_packet;	/* (in) setup packet (control only) */
	dma_addr_t setup_dma;		/* (in) dma addr for setup_packet */
	int start_frame;		/* (modify) start frame (ISO) */
	int number_of_packets;		/* (in) number of ISO packets */
	int interval;			/* (modify) transfer interval
					 * (INT/ISO) */
	int error_count;		/* (return) number of ISO errors */
	void *context;			/* (in) context for completion */
	usb_complete_t complete;	/* (in) completion routine */
	struct usb_iso_packet_descriptor iso_frame_desc[0];
					/* (in) ISO ONLY */
};

/**
  *	struct sock - network layer representation of sockets
  *	@__sk_common: shared layout with inet_timewait_sock
  *	@sk_shutdown: mask of %SEND_SHUTDOWN and/or %RCV_SHUTDOWN
  *	@sk_userlocks: %SO_SNDBUF and %SO_RCVBUF settings
  *	@sk_lock:	synchronizer
  *	@sk_rcvbuf: size of receive buffer in bytes
  *	@sk_sleep: sock wait queue
  *	@sk_dst_cache: destination cache
  *	@sk_dst_lock: destination cache lock
  *	@sk_policy: flow policy
  *	@sk_rmem_alloc: receive queue bytes committed
  *	@sk_receive_queue: incoming packets
  *	@sk_wmem_alloc: transmit queue bytes committed
  *	@sk_write_queue: Packet sending queue
  *	@sk_async_wait_queue: DMA copied packets
  *	@sk_omem_alloc: "o" is "option" or "other"
  *	@sk_wmem_queued: persistent queue size
  *	@sk_forward_alloc: space allocated forward
  *	@sk_allocation: allocation mode
  *	@sk_sndbuf: size of send buffer in bytes
  *	@sk_flags: %SO_LINGER (l_onoff), %SO_BROADCAST, %SO_KEEPALIVE,
  *		   %SO_OOBINLINE settings, %SO_TIMESTAMPING settings
  *	@sk_no_check: %SO_NO_CHECK setting, wether or not checkup packets
  *	@sk_route_caps: route capabilities (e.g. %NETIF_F_TSO)
  *	@sk_gso_type: GSO type (e.g. %SKB_GSO_TCPV4)
  *	@sk_gso_max_size: Maximum GSO segment size to build
  *	@sk_lingertime: %SO_LINGER l_linger setting
  *	@sk_backlog: always used with the per-socket spinlock held
  *	@sk_callback_lock: used with the callbacks in the end of this struct
  *	@sk_error_queue: rarely used
  *	@sk_prot_creator: sk_prot of original sock creator (see ipv6_setsockopt,
  *			  IPV6_ADDRFORM for instance)
  *	@sk_err: last error
  *	@sk_err_soft: errors that don't cause failure but are the cause of a
  *		      persistent failure not just 'timed out'
  *	@sk_drops: raw/udp drops counter
  *	@sk_ack_backlog: current listen backlog
  *	@sk_max_ack_backlog: listen backlog set in listen()
  *	@sk_priority: %SO_PRIORITY setting
  *	@sk_type: socket type (%SOCK_STREAM, etc)
  *	@sk_protocol: which protocol this socket belongs in this network family
  *	@sk_peercred: %SO_PEERCRED setting
  *	@sk_rcvlowat: %SO_RCVLOWAT setting
  *	@sk_rcvtimeo: %SO_RCVTIMEO setting
  *	@sk_sndtimeo: %SO_SNDTIMEO setting
  *	@sk_filter: socket filtering instructions
  *	@sk_protinfo: private area, net family specific, when not using slab
  *	@sk_timer: sock cleanup timer
  *	@sk_stamp: time stamp of last packet received
  *	@sk_socket: Identd and reporting IO signals
  *	@sk_user_data: RPC layer private data
  *	@sk_sndmsg_page: cached page for sendmsg
  *	@sk_sndmsg_off: cached offset for sendmsg
  *	@sk_send_head: front of stuff to transmit
  *	@sk_security: used by security modules
  *	@sk_mark: generic packet mark
  *	@sk_write_pending: a write to stream socket waits to start
  *	@sk_state_change: callback to indicate change in the state of the sock
  *	@sk_data_ready: callback to indicate there is data to be processed
  *	@sk_write_space: callback to indicate there is bf sending space available
  *	@sk_error_report: callback to indicate errors (e.g. %MSG_ERRQUEUE)
  *	@sk_backlog_rcv: callback to process the backlog
  *	@sk_destruct: called at sock freeing time, i.e. when all refcnt == 0
 */
struct sock {
	/*
	 * Now struct inet_timewait_sock also uses sock_common, so please just
	 * don't add nothing before this first member (__sk_common) --acme
	 */
	struct sock_common	__sk_common;
#define sk_family		__sk_common.skc_family
#define sk_state		__sk_common.skc_state
#define sk_reuse		__sk_common.skc_reuse
#define sk_bound_dev_if		__sk_common.skc_bound_dev_if
#define sk_node			__sk_common.skc_node
#define sk_nulls_node		__sk_common.skc_nulls_node
#define sk_bind_node		__sk_common.skc_bind_node
#define sk_refcnt		__sk_common.skc_refcnt
#define sk_hash			__sk_common.skc_hash
#define sk_prot			__sk_common.skc_prot
#define sk_net			__sk_common.skc_net
	kmemcheck_bitfield_begin(flags);
	unsigned char		sk_shutdown : 2,
				sk_no_check : 2,
				sk_userlocks : 4;
	kmemcheck_bitfield_end(flags);
	unsigned char		sk_protocol;
	unsigned short		sk_type;
	int			sk_rcvbuf;
	socket_lock_t		sk_lock;
	/*
	 * The backlog queue is special, it is always used with
	 * the per-socket spinlock held and requires low latency
	 * access. Therefore we special case it's implementation.
	 */
	struct {
		struct sk_buff *head;
		struct sk_buff *tail;
	} sk_backlog;
	wait_queue_head_t	*sk_sleep;
	struct dst_entry	*sk_dst_cache;
#ifdef CONFIG_XFRM
	struct xfrm_policy	*sk_policy[2];
#endif
	rwlock_t		sk_dst_lock;
	atomic_t		sk_rmem_alloc;
	atomic_t		sk_wmem_alloc;
	atomic_t		sk_omem_alloc;
	int			sk_sndbuf;
	struct sk_buff_head	sk_receive_queue;
	struct sk_buff_head	sk_write_queue;
#ifdef CONFIG_NET_DMA
	struct sk_buff_head	sk_async_wait_queue;
#endif
	int			sk_wmem_queued;
	int			sk_forward_alloc;
	gfp_t			sk_allocation;
	int			sk_route_caps;
	int			sk_gso_type;
	unsigned int		sk_gso_max_size;
	int			sk_rcvlowat;
	unsigned long 		sk_flags;
	unsigned long	        sk_lingertime;
	struct sk_buff_head	sk_error_queue;
	struct proto		*sk_prot_creator;
	rwlock_t		sk_callback_lock;
	int			sk_err,
				sk_err_soft;
	atomic_t		sk_drops;
	unsigned short		sk_ack_backlog;
	unsigned short		sk_max_ack_backlog;
	__u32			sk_priority;
	struct ucred		sk_peercred;
	long			sk_rcvtimeo;
	long			sk_sndtimeo;
	struct sk_filter      	*sk_filter;
	void			*sk_protinfo;
	struct timer_list	sk_timer;
	ktime_t			sk_stamp;
	struct socket		*sk_socket;
	void			*sk_user_data;
	struct page		*sk_sndmsg_page;
	struct sk_buff		*sk_send_head;
	__u32			sk_sndmsg_off;
	int			sk_write_pending;
#ifdef CONFIG_SECURITY
	void			*sk_security;
#endif
	__u32			sk_mark;
	/* XXX 4 bytes hole on 64 bit */
	void			(*sk_state_change)(struct sock *sk);
	void			(*sk_data_ready)(struct sock *sk, int bytes);
	void			(*sk_write_space)(struct sock *sk);
	void			(*sk_error_report)(struct sock *sk);
  	int			(*sk_backlog_rcv)(struct sock *sk,
						  struct sk_buff *skb);  
	void                    (*sk_destruct)(struct sock *sk);
};

/**
 * is_etherdev_addr - Tell if given Ethernet address belongs to the device.
 * @dev: Pointer to a device structure
 * @addr: Pointer to a six-byte array containing the Ethernet address
 *
 * Compare passed address with all addresses of the device. Return true if the
 * address if one of the device addresses.
 *
 * Note that this function calls compare_ether_addr_64bits() so take care of
 * the right padding.
 */
static inline bool is_etherdev_addr(const struct net_device *dev,
				    const u8 addr[6 + 2])
{
	struct netdev_hw_addr *ha;
	int res = 1;

	rcu_read_lock();
	for_each_dev_addr(dev, ha) {
		res = compare_ether_addr_64bits(addr, ha->addr);
		if (!res)
			break;
	}
	rcu_read_unlock();
	return !res;
}

/**
 * flex_array_shrink - free unused second-level pages
 *
 * Frees all second-level pages that consist solely of unused
 * elements.  Returns the number of pages freed.
 *
 * Locking must be provided by the caller.
 */
int flex_array_shrink(struct flex_array *fa)
{
}

/* weird kernel-doc error from Johannes Berg on: */
#define FOO 10
/**
 * struct foo - test kernel-doc struct errors
 * @a: some field with attributes
 * @b: some field with other attributes
 */
struct foo {
	u8 a[0]
                __attribute__((__aligned(sizeof(void *))));
	u8 b[0]
                __attribute__((__aligned__(FOO)));
};

/**
 *	dev_alloc_name - allocate a name for a device
 *	@dev: device
 *	@name: name format string
 *
 *	Passed a format string - eg "lt%d" it will try and find a suitable
 *	id. It scans list of devices to build up a free map, then chooses
 *	the first empty slot. The caller must hold the dev_base or rtnl lock
 *	while allocating the name and adding the device in order to avoid
 *	duplicates.
 *	Limited to bits_per_byte * page size devices (ie 32K on most platforms).
 *	Returns the number of the unit assigned or a negative errno code.
 */
int dev_alloc_name(struct net_device *dev, const char *name)
{
}

/**
 * struct - i/q coordinate.
 *
 * @i: real part of coordinate (in phase).
 * @q: imaginary part of coordinate (quadrature).
 */
struct cordic_iq {
	s32 i;
	s32 q;
};

/**
 * struct nand_flash_dev - NAND Flash Device ID Structure
 * @name: a human-readable name of the NAND chip
 * @dev_id: the device ID (the second byte of the full chip ID array)
 * @mfr_id: manufecturer ID part of the full chip ID array (refers the same
 *          memory address as @id[0])
 * @dev_id: device ID part of the full chip ID array (refers the same memory
 *          address as @id[1])
 * @id: full device ID array
 * @pagesize: size of the NAND page in bytes; if 0, then the real page size (as
 *            well as the eraseblock size) is determined from the extended NAND
 *            chip ID array)
 * @chipsize: total chip size in MiB
 * @erasesize: eraseblock size in bytes (determined from the extended ID if 0)
 * @options: stores various chip bit options
 * @id_len: The valid length of the @id.
 * @oobsize: OOB size
 * @ecc: ecc parameters from datasheet
 * @ecc.strength_ds: The ECC correctability from the datasheet, same as the
 *                   @ecc_strength_ds in nand_chip{}.
 * @ecc.step_ds: The ECC step required by the @ecc.strength_ds, same as the
 *               @ecc_step_ds in nand_chip{}, also from the datasheet.
 *               For example, the "4bit ECC for each 512Byte" can be set with
 *               NAND_ECC_INFO(4, 512).
 * WITHOUT named nested unions/structs;
 */
struct nand_flash_dev {
	char *name;
	union {
		struct {
			uint8_t mfr_id;
			uint8_t dev_id;
		};
		uint8_t id[NAND_MAX_ID_LEN];
	};
	unsigned int pagesize;
	unsigned int chipsize;
	unsigned int erasesize;
	unsigned int options;
	uint16_t id_len;
	uint16_t oobsize;
	struct {
		uint16_t strength_ds;
		uint16_t step_ds;
	} ecc;
};

/**
 * struct nand_flash_device - NAND Flash Device ID Structure
 * @name: a human-readable name of the NAND chip
 * @dev_id: the device ID (the second byte of the full chip ID array)
 * @mfr_id: manufecturer ID part of the full chip ID array (refers the same
 *          memory address as @id[0])
 * @dev_id: device ID part of the full chip ID array (refers the same memory
 *          address as @id[1])
 * @id: full device ID array
 * @pagesize: size of the NAND page in bytes; if 0, then the real page size (as
 *            well as the eraseblock size) is determined from the extended NAND
 *            chip ID array)
 * @chipsize: total chip size in MiB
 * @erasesize: eraseblock size in bytes (determined from the extended ID if 0)
 * @options: stores various chip bit options
 * @id_len: The valid length of the @id.
 * @oobsize: OOB size
 * @ecc: ecc parameters from datasheet
 * @ecc.strength_ds: The ECC correctability from the datasheet, same as the
 *                   @ecc_strength_ds in nand_chip{}.
 * @ecc.step_ds: The ECC step required by the @ecc.strength_ds, same as the
 *               @ecc_step_ds in nand_chip{}, also from the datasheet.
 *               For example, the "4bit ECC for each 512Byte" can be set with
 *               NAND_ECC_INFO(4, 512).
 * WITH named nested unions/structs;
 */
struct nand_flash_device {
	char *name;
	union u_ids_ary {
		struct nand_ids {
			uint8_t mfr_id;
			uint8_t dev_id;
		} ids;
		uint8_t id[NAND_MAX_ID_LEN];
	} ids_ary;
	unsigned int pagesize;
	unsigned int chipsize;
	unsigned int erasesize;
	unsigned int options;
	uint16_t id_len;
	uint16_t oobsize;
	struct ecc_ds {
		uint16_t strength_ds;
		uint16_t step_ds;
	} ecc;
};

/**
 * crc32_le_generic() - Calculate bitwise little-endian Ethernet AUTODIN II
 *			CRC32/CRC32C
 * @crc: seed value for computation.  ~0 for Ethernet, sometimes 0 for other
 *	 uses, or the previous crc32/crc32c value if computing incrementally.
 * @p: pointer to buffer over which CRC32/CRC32C is run
 * @len: length of buffer @p
 * @tab: little-endian Ethernet table
 * @polynomial: CRC32/CRC32c LE polynomial
 */
static inline u32 __pure crc32_le_generic(u32 crc, unsigned char const *p,
					  size_t len, const u32 (*tab)[256],
					  u32 polynomial)
{
	return crc;
}

/**
 * strreplace - Replace all occurrences of character in string.
 * @s: The string to operate on.
 * @old: The character being replaced.
 * @new: The character @old is replaced with.
 *
 * Returns pointer to the nul byte at the end of @s.
 */
char *strreplace(char *s, char old, char new)
{
	for (; *s; ++s)
		if (*s == old)
			*s = new;
	return s;
}

--------------F81CF100721AEEBDC6EE764B--
